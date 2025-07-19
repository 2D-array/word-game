// lib/features/game/presentation/bloc/game_bloc.dart

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/game_respository.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;
  GameBloc({required this.gameRepository}) : super(GameState.initial()) {
    on<StartGameEvent>(onStartGameEvent);
    on<EnterKeyEvent>(onEnterKeyEvent);
    on<DeleteKeyEvent>(onDeleteKeyEvent);
    on<EnterAttemptEvent>(onEnterAttemptEvent);
  }

  Future<void> onStartGameEvent(StartGameEvent event, Emitter<GameState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    var result = await gameRepository.getRandomWord(event.wordLength);
    result.fold(
            (failure) {
          emit(state.copyWith(
              status: GameStatus.error,
              errorMessage: failure.message
          ));
        },
            (word) {
          emit(state.copyWith(
            status: GameStatus.inProgress,
            word: word.toUpperCase(),  // Changed from r.toUpperCase() to word.toUpperCase()
            attemptsCount: event.attemptsCount,
            wordLength: event.wordLength,
          ));
        }
    );
  }

  Future<void> onEnterKeyEvent(EnterKeyEvent event, Emitter<GameState> emit) async {
    var currentAttempts = state.currentAttempts ?? '';
    var word = state.word ?? '';

    if (word.isEmpty) {
      return;
    }
    if (currentAttempts.length >= word.length) {
      return;
    }

    emit(state.copyWith(
      currentAttempts: currentAttempts + event.key.toUpperCase(), // Optionally make input uppercase
      status: GameStatus.inProgress,
    ));
  }

  Future<void> onDeleteKeyEvent(DeleteKeyEvent event, Emitter<GameState> emit) async {
    var currentAttempts = state.currentAttempts ?? '';
    if (currentAttempts.isEmpty) {
      return;
    }
    emit(state.copyWith(
      status: GameStatus.inProgress,
      currentAttempts: currentAttempts.substring(0, currentAttempts.length - 1),
    ));
  }

  Future<void> onEnterAttemptEvent(EnterAttemptEvent event, Emitter<GameState> emit) async {
    var word = state.word ?? '';
    var currentAttempts = state.currentAttempts ?? '';
    var attempts = state.attempts ?? [];

    if (word.isEmpty || currentAttempts.length < word.length) {
      return;
    }
    // var checkWord = await gameRepository.checkWord(currentAttempts);
    // checkWord.fold((l){
    //   emit(state.copyWith(status: GameStatus.error, errorMessage: l.message, currentAttempts: ''));
    // }, (r){
      emit(state.copyWith(
        status: GameStatus.inProgress,
        attempts: [...attempts, currentAttempts],
        currentAttempts: '',
      ));

      if (word.toUpperCase() == currentAttempts.toUpperCase()) {
        emit(state.copyWith(status: GameStatus.win));
      } else if ((state.attempts?.length ?? 0) == (state.attemptsCount ?? 0)) {
        emit(state.copyWith(status: GameStatus.loss));
      }
    }
  }
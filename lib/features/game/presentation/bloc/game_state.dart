// lib/features/game/presentation/bloc/game_state.dart

enum GameStatus { initial, loading, inProgress, win, loss, error }

class GameState {
  final GameStatus status;
  final String? errorMessage;

  final List<String>? attempts;
  final String? currentAttempts;

  final String? word;
  final int? attemptsCount;
  final int? wordLength; // ✅ ADDED THIS

  GameState._({
    required this.status,
    this.errorMessage,
    this.attempts,
    this.currentAttempts,
    this.word,
    this.attemptsCount,
    this.wordLength, // ✅ ADDED THIS
  });

  factory GameState.initial() => GameState._(status: GameStatus.initial);

  GameState copyWith({
    GameStatus? status,
    String? errorMessage,
    List<String>? attempts,
    String? currentAttempts,
    String? word,
    int? attemptsCount,
    int? wordLength, // ✅ ADDED THIS
  }) =>
      GameState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        attempts: attempts ?? this.attempts,
        currentAttempts: currentAttempts ?? this.currentAttempts,
        word: word ?? this.word,
        attemptsCount: attemptsCount ?? this.attemptsCount,
        wordLength: wordLength ?? this.wordLength, // ✅ ADDED THIS
      );
}
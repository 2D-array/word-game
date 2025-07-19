import 'package:dio/dio.dart';
import 'package:word_game/core/failure/failure.dart';
import 'package:word_game/core/model/either.dart';
import 'package:word_game/features/game/data/datasource/game_remote_datasource.dart';
import 'package:word_game/features/game/domain/game_respository.dart';

class GameRepositoryImpl implements GameRepository{
  final GameRemoteDatasource gameRemoteDatasource;

  GameRepositoryImpl({required this.gameRemoteDatasource});

  @override
  Future<Either<Failure, void>> checkWord(String word) async {
    try{
      var result = await gameRemoteDatasource.checkWord(word);
      return Right(null);
    }
    on DioException {
      return Left(GameFailure(message: 'Please, enter correct word'));
    }
    catch (e){
      return Left(GameFailure(message: 'Please, enter correct word'));
    }
  }

  @override
  Future<Either<Failure, String>> getRandomWord(int length) async {
    try{
      var result = await gameRemoteDatasource.getRandomWord(length);
      try{
        await gameRemoteDatasource.checkWord(result);
      }
      catch (e){
        return getRandomWord(length);
      }
      return Right(result);
    }
    catch (e){
      return Left(GameFailure(message: 'Error'));
    }
  }
}
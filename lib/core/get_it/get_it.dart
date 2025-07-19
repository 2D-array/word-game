import 'package:get_it/get_it.dart';
import 'package:word_game/features/game/presentation/bloc/game_bloc.dart';
import 'package:word_game/core/api/dio_client.dart';
import 'package:word_game/features/game/data/datasource/game_remote_datasource.dart';
import 'package:word_game/features/game/domain/game_respository.dart';
import '../../features/game/data/repository/game_repository_impl.dart';

var getIt = GetIt.instance;

void setup(){
  registerDatasources();
  registerRepositories();
  registerBloc();
}
void registerDatasources(){
  getIt.registerSingleton(GameRemoteDatasource(dio: DioClient.getDio()));
}
void registerRepositories(){
  getIt.registerSingleton<GameRepository>(GameRepositoryImpl(gameRemoteDatasource: getIt()));
}
void registerBloc(){
  getIt.registerFactory<GameBloc>(() => GameBloc(gameRepository: getIt()));
}
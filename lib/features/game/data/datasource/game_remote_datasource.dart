import 'package:dio/dio.dart';

class GameRemoteDatasource{
  final Dio dio;

  GameRemoteDatasource({required this.dio});

  Future<String> getRandomWord(int length) async{
    var result = await dio.get('https://random-word-api.herokuapp.com/word',queryParameters: {
      'length' : length,
    });
    return (result.data as List).first;
  }

  Future checkWord(String word) async{
    var result = await dio.get('https://api.dictionaryapi.dev/api/v2/entries/en/$word');
    return;
  }
}
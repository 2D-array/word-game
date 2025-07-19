abstract class Failure{
  final String message;

  Failure({required this.message});
}

class GameFailure extends Failure{
  GameFailure({required super.message});

}
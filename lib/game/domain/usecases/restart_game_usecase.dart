import "package:tic_tac_toe/game/domain/entities/game/game.dart";

final class RestartGameUsecase {
  RestartGameUsecase(Game game) : _game = game;

  final Game _game;

  void call() => _game.restart();
}

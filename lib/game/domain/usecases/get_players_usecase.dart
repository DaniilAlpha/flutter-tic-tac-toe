import "package:tic_tac_toe/game/domain/entities/game/game.dart";

final class GetPlayersUsecase {
  GetPlayersUsecase(Game game) : _game = game;

  final Game _game;

  Player get currentPlayer => _game.player;
  Player? get winner => _game.winner;
}

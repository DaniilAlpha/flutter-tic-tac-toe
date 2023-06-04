import "package:tic_tac_toe/game/domain/entities/field/field.dart";
import "package:tic_tac_toe/game/domain/entities/game/game.dart";

final class MarkUsecase {
  MarkUsecase(Game game) : _game = game;

  final Game _game;

  Player get _player => _game.player;

  bool call(FieldPos pos) => _game.playTurn(pos, _player.info);
}

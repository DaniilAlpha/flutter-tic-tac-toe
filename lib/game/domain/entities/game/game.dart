import "package:tic_tac_toe/game/domain/entities/field/field.dart";
import "package:tic_tac_toe/game/domain/entities/player_info.dart";

part "player.dart";

final class Game {
  Game({required Field field, required List<PlayerInfo> playerInfos})
      : _field = field,
        _players = List.generate(
          playerInfos.length,
          (i) => Player(playerInfos[i]),
          growable: false,
        ) {
    _mapCellValues();
  }

  final Field _field;

  final List<Player> _players;
  Player get player => _players[_turn];

  var _isStraightTurnOrder = true;
  late int _turn = _firstTurn;
  int get _firstTurn => _isStraightTurnOrder ? 0 : _players.length - 1;

  var _isEnded = false;
  Player? _winner;
  Player? get winner => _winner;

  bool playTurn(FieldPos pos, PlayerInfo playerInfo) {
    if (_isEnded) throw GameAlreadyEndedException();
    if (player.info != playerInfo) throw NotYourTurnException();

    _field.mark(pos, player._cellValue);
    _checkEndConditions(player);
    if (!_isEnded) _setNextTurn();

    return _isEnded;
  }

  void restart() {
    _field.clear();

    _isEnded = false;
    _winner = null;

    _setOppositeTurnOrder();
    _mapCellValues();
  }

  void _checkEndConditions(Player player) {
    if (_field.lineFullOf(player._cellValue) != null) {
      player._score++;
      _winner = player;
      _isEnded = true;
    } else if (_field.isFull) {
      _isEnded = true;
    }
  }

  void _setNextTurn() {
    if (_isStraightTurnOrder) {
      _turn++;
      if (_turn >= _players.length) _turn = _firstTurn;
    } else {
      _turn--;
      if (_turn < 0) _turn = _firstTurn;
    }
  }

  void _setOppositeTurnOrder() {
    _isStraightTurnOrder = !_isStraightTurnOrder;
    _turn = _firstTurn;
  }

  void _mapCellValues() {
    for (final (i, e) in _players.indexed) {
      e._cellValue =
          (i % 2 == 0) == _isStraightTurnOrder ? CellValue.X : CellValue.O;
    }
  }
}

final class GameAlreadyEndedException implements Exception {
  GameAlreadyEndedException([this.message]);

  final String? message;

  @override
  String toString() => message == null
      ? "Game already ended"
      : "Game already ended: ${Error.safeToString(message)}";
}

final class NotYourTurnException implements Exception {
  NotYourTurnException([this.message]);

  final String? message;

  @override
  String toString() => message == null
      ? "Not your turn"
      : "Not your turn: ${Error.safeToString(message)}";
}

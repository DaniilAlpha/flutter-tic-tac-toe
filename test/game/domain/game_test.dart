import "package:flutter_test/flutter_test.dart";
import "package:tic_tac_toe/game/domain/entities/field/field.dart";
import "package:tic_tac_toe/game/domain/entities/game/game.dart";
import "package:tic_tac_toe/game/domain/entities/player_info.dart";

void main() {
  test("game respects turn", () async {
    final playerX = PlayerInfo(null), playerO = PlayerInfo(null);
    final game = Game(field: Field(1, 1), playerInfos: [playerX, playerO]);
    game.playTurn(const FieldPos(0, 0), playerX);
    expect(game.winner!.info, playerX);
  });

  test("game respects turn even if cell is already marked", () async {
    final throwsFieldPosAlreadyMarkedException =
        throwsA(const TypeMatcher<FieldPosAlreadyMarkedException>());

    final playerX = PlayerInfo(null), playerO = PlayerInfo(null);
    final field = Field(2, 2)..markX(const FieldPos(0, 0));
    final game = Game(
      field: field,
      playerInfos: [playerX, playerO],
    );
    expect(
      () => game.playTurn(const FieldPos(0, 0), playerX),
      throwsFieldPosAlreadyMarkedException,
    );
    game.playTurn(const FieldPos(1, 0), playerX);
    expect(game.winner!.info, playerX);
  });

  test("game can be restarted", () async {
    final playerX = PlayerInfo(null), playerO = PlayerInfo(null);
    final game = Game(field: Field(1, 1), playerInfos: [playerX, playerO]);
    game.playTurn(const FieldPos(0, 0), playerX);
    game.restart();
    game.playTurn(const FieldPos(0, 0), playerO);
    expect(game.winner!.info, playerO);
  });

  test("horizontal line completes a game", () async {
    final playerX = PlayerInfo(null);
    final game = Game(
      field: Field(4, 3)
        ..markX(const FieldPos(0, 0))
        ..markX(const FieldPos(1, 0))
        ..markX(const FieldPos(2, 0)),
      playerInfos: [playerX],
    );
    expect(game.playTurn(const FieldPos(3, 0), playerX), true);
  });

  test("vartical line completes a game", () async {
    final playerX = PlayerInfo(null);
    final game = Game(
      field: Field(4, 3)
        ..markX(const FieldPos(0, 0))
        ..markX(const FieldPos(0, 1)),
      playerInfos: [playerX],
    );
    expect(game.playTurn(const FieldPos(0, 2), playerX), true);
  });

  test("diagonal line completes a game", () async {
    final playerX = PlayerInfo(null);
    final game = Game(
      field: Field(4, 3)
        ..markX(const FieldPos(0, 0))
        ..markX(const FieldPos(1, 1)),
      playerInfos: [playerX],
    );
    expect(game.playTurn(const FieldPos(2, 2), playerX), true);
  });

  test("second diagonal line also completes a game", () async {
    final playerX = PlayerInfo(null);
    final game = Game(
      field: Field(4, 3)
        ..markX(const FieldPos(1, 0))
        ..markX(const FieldPos(2, 1)),
      playerInfos: [playerX],
    );
    expect(game.playTurn(const FieldPos(3, 2), playerX), true);
  });

  test("vertical diagonal line also completes a game", () async {
    final playerX = PlayerInfo(null);
    final game = Game(
      field: Field(3, 4)
        ..markX(const FieldPos(0, 1))
        ..markX(const FieldPos(1, 2)),
      playerInfos: [playerX],
    );
    expect(game.playTurn(const FieldPos(2, 3), playerX), true);
  });

  test("cross diagonal line completes a game", () async {
    final playerX = PlayerInfo(null);
    final game = Game(
      field: Field(4, 3)
        ..markX(const FieldPos(2, 0))
        ..markX(const FieldPos(1, 1)),
      playerInfos: [playerX],
    );
    expect(game.playTurn(const FieldPos(0, 2), playerX), true);
  });

  test("second cross diagonal line also completes a game", () async {
    final playerX = PlayerInfo(null);
    final game = Game(
      field: Field(4, 3)
        ..markX(const FieldPos(3, 0))
        ..markX(const FieldPos(2, 1)),
      playerInfos: [playerX],
    );
    expect(game.playTurn(const FieldPos(1, 2), playerX), true);
  });

  test("vertical cross diagonal line also completes a game", () async {
    final playerX = PlayerInfo(null);
    final game = Game(
      field: Field(3, 4)
        ..markX(const FieldPos(2, 1))
        ..markX(const FieldPos(1, 2)),
      playerInfos: [playerX],
    );
    expect(game.playTurn(const FieldPos(0, 3), playerX), true);
  });

  test("draw also completes a game", () async {
    final playerX = PlayerInfo(null);
    final game = Game(
      field: Field(3, 3)
        ..markX(const FieldPos(0, 0))
        ..markO(const FieldPos(1, 0))
        ..markX(const FieldPos(2, 0))
        ..markX(const FieldPos(0, 1))
        ..markO(const FieldPos(1, 1))
        ..markX(const FieldPos(2, 1))
        ..markO(const FieldPos(0, 2))
        // ..markX(const FieldPos(1, 2))
        ..markO(const FieldPos(2, 2)),
      playerInfos: [playerX],
    );
    game.playTurn(const FieldPos(1, 2), playerX);
    expect(game.winner, null);
  });
}

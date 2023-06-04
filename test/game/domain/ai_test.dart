import "package:flutter_test/flutter_test.dart";
import "package:tic_tac_toe/game/domain/entities/ai.dart";
import "package:tic_tac_toe/game/domain/entities/field/field.dart";
import "package:tic_tac_toe/game/domain/entities/game/game.dart";
import "package:tic_tac_toe/game/domain/entities/player_info.dart";

void main() {
  test("ai protects itself", () {
    final ai = Ai(
      field: Field(3, 3)
        ..markX(const FieldPos(0, 0))
        ..markX(const FieldPos(1, 0)),
    );
    expect(ai.pickBestPosFor(CellValue.O), const FieldPos(2, 0));
  });

  test("ai is trying to win", () {
    final ai = Ai(
      field: Field(3, 3)
        ..markX(const FieldPos(0, 0))
        ..markX(const FieldPos(0, 1))
        ..markO(const FieldPos(1, 0))
        ..markO(const FieldPos(1, 1))
        ..markO(const FieldPos(2, 0))
        ..markO(const FieldPos(2, 1)),
    );

    expect(ai.pickBestPosFor(CellValue.X), const FieldPos(0, 2));
  });

  test("ai vs ai is always draw", () {
    final field = Field(3, 3);
    final ai = Ai(field: field);
    final playerX = PlayerInfo(null), playerO = PlayerInfo(null);
    final game = Game(field: field, playerInfos: [playerX, playerO]);

    var isEnded = false;
    while (!isEnded) {
      final player = game.player;
      isEnded = game.playTurn(ai.pickBestPosFor(player.cellValue), player.info);
    }
    expect(game.winner, null);
  });
}

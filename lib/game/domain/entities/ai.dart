import "package:tic_tac_toe/game/domain/entities/field/field.dart";

class Ai {
  Ai({required Field field}) : _field = field;

  static const opsLimit = 6500000;

  final Field _field;
  late final _maxDepth = _countMaxDepth();

  FieldPos pickBestPosFor(CellValue cellValue) {
    final opponentCellValue =
        cellValue == CellValue.X ? CellValue.O : CellValue.X;

    FieldPos? bestPos;

    int minimax(Field field, {int depth = 0}) {
      if (field.lineFullOf(cellValue) != null) {
        return 1;
      } else if (field.lineFullOf(opponentCellValue) != null) {
        return -1;
      } else if (field.isFull) {
        return 0;
      }

      if (depth >= _maxDepth) return 0;

      final isForSelf = depth % 2 == 0;
      var bestScore = isForSelf ? -2000000000 : 2000000000;
      for (var y = 0; y < field.height; y++) {
        for (var x = 0; x < field.width; x++) {
          final pos = FieldPos(x, y);

          if (field.at(pos) == null) {
            if (depth == 0) bestPos ??= pos;

            final score = minimax(
              Field.copy(field)
                ..mark(pos, isForSelf ? cellValue : opponentCellValue),
              depth: depth + 1,
            );
            if (score > bestScore == isForSelf) {
              if (depth == 0) bestPos = pos;
              bestScore = score;
            }
          }
        }
      }

      return bestScore;
    }

    minimax(_field);

    return bestPos!;
  }

  int _countMaxDepth() {
    var opsCount = 1;
    for (var i = _field.size; i > 0; i--) {
      opsCount *= i;
      if (opsCount >= opsLimit) return _field.size - i;
    }
    return _field.size;
  }
}

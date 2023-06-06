import "dart:collection";

part "field_iterable.dart";
part "field_iterator.dart";
part "cell_value.dart";

final class Field {
  Field(this.width, this.height)
      : _cells = List.filled(width * height, null, growable: false);

  Field.copy(Field other)
      : width = other.width,
        height = other.height,
        _cells = List.from(other._cells, growable: false);

  final int width, height;
  late final size = width * height;
  final List<CellValue?> _cells;

  late final grid = FieldGridIterable(
    width: width,
    height: height,
    cells: _cells,
  );
  bool get isFull => grid.isFull;

  late final rows = List.generate(
    height,
    (y) => FieldAxisIterable(
      y,
      isRow: true,
      width: width,
      height: height,
      cells: _cells,
    ),
    growable: false,
  );
  late final columns = List.generate(
    width,
    (x) => FieldAxisIterable(
      x,
      isRow: false,
      width: width,
      height: height,
      cells: _cells,
    ),
    growable: false,
  );
  late final diagonals = List.generate(
    1 + (width - height).abs(),
    (n) => FieldDiagonalIterable(
      n,
      isStraight: true,
      width: width,
      height: height,
      cells: _cells,
    ),
    growable: false,
  );
  late final crossDiagonals = List.generate(
    1 + (width - height).abs(),
    (n) => FieldDiagonalIterable(
      n,
      isStraight: false,
      width: width,
      height: height,
      cells: _cells,
    ),
    growable: false,
  );
  late final _lines = [...rows, ...columns, ...diagonals, ...crossDiagonals];

  CellValue? at(FieldPos pos) => _cells[pos.x + pos.y * width];

  FieldLineIterable? lineFullOf(CellValue cellValue) {
    for (final line in _lines) {
      if (line.isFullOf(cellValue)) return line;
    }

    return null;
  }

  void markX(FieldPos pos) => mark(pos, CellValue.X);
  void markO(FieldPos pos) => mark(pos, CellValue.O);
  void mark(FieldPos pos, CellValue value) {
    if (at(pos) != null) throw FieldPosAlreadyMarkedException(pos);
    _cells[pos.x + pos.y * width] = value;
  }

  void clear() => _cells.fillRange(0, size, null);
}

final class FieldPos {
  const FieldPos(this.x, this.y);

  final int x, y;

  @override
  bool operator ==(Object other) =>
      other is FieldPos && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);
}

final class FieldPosAlreadyMarkedException implements Exception {
  FieldPosAlreadyMarkedException(this.pos, {this.message});

  final FieldPos pos;
  final String? message;

  @override
  String toString() => message == null
      ? "FieldPos(${pos.x}, ${pos.y}) is already marked"
      : "FieldPos(${pos.x}, ${pos.y}) is already marked: ${Error.safeToString(message)}";
}

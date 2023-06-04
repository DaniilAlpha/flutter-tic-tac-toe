part of "field.dart";

abstract base class _FieldBaseIterable with IterableMixin<CellValue?> {
  _FieldBaseIterable({
    required this.width,
    required this.height,
    required List<CellValue?> cells,
  }) : _cells = cells;

  final int width, height;
  final List<CellValue?> _cells;

  bool get isFull => every((element) => element != null);

  bool isFullOf(CellValue cellValue) =>
      every((element) => element == cellValue);
}

final class FieldGridIterable extends _FieldBaseIterable {
  FieldGridIterable({
    required super.width,
    required super.height,
    required super.cells,
  });

  @override
  FieldGridIterator get iterator =>
      FieldGridIterator(width: width, height: height, cells: _cells);
}

final class FieldAxisIterable extends _FieldBaseIterable {
  FieldAxisIterable(
    this.n, {
    required this.isRow,
    required super.width,
    required super.height,
    required super.cells,
  });

  final int n;
  final bool isRow;

  @override
  FieldAxisIterator get iterator => FieldAxisIterator(n,
      isRow: isRow, width: width, height: height, cells: _cells);
}

final class FieldDiagonalIterable extends _FieldBaseIterable {
  FieldDiagonalIterable(
    this.n, {
    required this.isLtR,
    required super.width,
    required super.height,
    required super.cells,
  });

  final int n;
  final bool isLtR;

  @override
  FieldDiagonalIterator get iterator => FieldDiagonalIterator(n,
      isLtR: isLtR, width: width, height: height, cells: _cells);
}

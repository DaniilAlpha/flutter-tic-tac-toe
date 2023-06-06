part of "field.dart";

sealed class _FieldBaseIterable with IterableMixin<CellValue?> {
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

sealed class FieldLineIterable extends _FieldBaseIterable {
  FieldLineIterable({
    required super.width,
    required super.height,
    required super.cells,
  });
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

final class FieldAxisIterable extends FieldLineIterable {
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

final class FieldDiagonalIterable extends FieldLineIterable {
  FieldDiagonalIterable(
    this.n, {
    required this.isStraight,
    required super.width,
    required super.height,
    required super.cells,
  });

  final int n;
  final bool isStraight;
  late final bool isHorizontal = width > height;

  @override
  FieldDiagonalIterator get iterator => FieldDiagonalIterator(
        n,
        isStraight: isStraight,
        isHorizontal: isHorizontal,
        width: width,
        height: height,
        cells: _cells,
      );
}

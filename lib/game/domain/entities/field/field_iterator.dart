part of "field.dart";

sealed class _FieldBaseIterator implements Iterator<CellValue?> {
  _FieldBaseIterator({
    required this.width,
    required this.height,
    required List<CellValue?> cells,
  }) : _cells = cells;

  final int width, height;
  final List<CellValue?> _cells;

  late int _x, _y;

  @override
  CellValue? get current => _cells[_x + _y * width];
}

sealed class FieldLineIterator extends _FieldBaseIterator {
  FieldLineIterator({
    required super.width,
    required super.height,
    required super.cells,
  });
}

final class FieldGridIterator extends _FieldBaseIterator {
  FieldGridIterator({
    required super.width,
    required super.height,
    required super.cells,
  }) {
    _x = -1;
    _y = 0;
  }

  @override
  bool moveNext() {
    _x++;
    if (_x < width) return true;

    _x = 0;
    _y++;
    if (_y < height) return true;

    return false;
  }
}

final class FieldAxisIterator extends FieldLineIterator {
  FieldAxisIterator(
    int n, {
    required this.isRow,
    required super.width,
    required super.height,
    required super.cells,
  }) {
    _x = isRow ? -1 : n;
    _y = isRow ? n : -1;
  }

  final bool isRow;

  @override
  bool moveNext() {
    if (isRow) {
      _x++;
      if (_x < width) return true;
    } else {
      _y++;
      if (_y < height) return true;
    }
    return false;
  }
}

final class FieldDiagonalIterator extends FieldLineIterator {
  FieldDiagonalIterator(
    int n, {
    required this.isStraight,
    required this.isHorizontal,
    required super.width,
    required super.height,
    required super.cells,
  }) {
    if (isHorizontal) {
      _x = n - 1;
      _y = isStraight ? -1 : (height - 1) + 1;
    } else {
      _x = isStraight ? -1 : (width - 1) + 1;
      _y = n - 1;
    }
  }

  final bool isStraight, isHorizontal;

  @override
  bool moveNext() {
    if (isHorizontal) {
      _x++;
      isStraight ? _y++ : _y--;
      if (_x < width && (isStraight ? _y < height : _y >= 0)) return true;
    } else {
      isStraight ? _x++ : _x--;
      _y++;
      if ((isStraight ? _x < width : _x >= 0) && _y < height) return true;
    }
    return false;
  }
}

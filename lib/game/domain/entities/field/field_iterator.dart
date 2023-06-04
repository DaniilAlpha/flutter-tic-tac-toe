part of "field.dart";

abstract base class _FieldBaseIterator implements Iterator<CellValue?> {
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

final class FieldAxisIterator extends _FieldBaseIterator {
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

final class FieldDiagonalIterator extends _FieldBaseIterator {
  FieldDiagonalIterator(
    int n, {
    required this.isLtR,
    required super.width,
    required super.height,
    required super.cells,
  }) {
    if (width > height) {
      _x = isLtR ? n - 1 : -n + (width - 1) + 1;
      _y = -1;
    } else {
      _x = isLtR ? -1 : (width - 1) + 1;
      _y = n - 1;
    }
  }

  final bool isLtR;

  @override
  bool moveNext() {
    if (isLtR) {
      _x++;
      _y++;
      if (_x < width && _y < height) return true;
    } else {
      _x--;
      _y++;
      if (_x >= 0 && _y < height) return true;
    }
    return false;
  }
}

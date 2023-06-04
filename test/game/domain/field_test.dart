import "package:flutter_test/flutter_test.dart";
import "package:tic_tac_toe/game/domain/entities/field/field.dart";

String _fieldToString(Field field) {
  const separator = "|";

  final result = StringBuffer();
  for (final row in field.rows) {
    result.write(separator);
    for (final e in row) {
      result
        ..write(e?.name ?? "_")
        ..write(separator);
    }
    result.write("\n");
  }

  return result.toString();
}

void main() {
  test("new field is empty", () {
    final field = Field(1, 1);

    expect(field.at(const FieldPos(0, 0)), null);
  });

  test("field's iterators are working", () {
    final field = Field(2, 3)
      ..markX(const FieldPos(0, 0))
      ..markO(const FieldPos(1, 1));

    /*
     *|X|_|
     *|_|O|
     *|_|_|
     */

    expect(field.grid, [CellValue.X, null, null, CellValue.O, null, null]);
    expect(field.rows[0], [CellValue.X, null]);
    expect(field.columns[1], [null, CellValue.O, null]);
    expect(field.diagonals[0], [CellValue.X, CellValue.O]);
    expect(field.diagonals[1], [null, null]);
    expect(field.crossDiagonals[0], [null, null]);
    expect(field.crossDiagonals[1], [CellValue.O, null]);
  });

  test("field to string is working", () {
    final field = Field(2, 2)..markX(const FieldPos(0, 0));

    expect(_fieldToString(field), "|X|_|\n|_|_|\n");
  });

  test("getting nonexistent cell throws RangeError", () {
    final field = Field(3, 3);

    expect(() => field.at(const FieldPos(-3, 0)), throwsRangeError);
    expect(() => field.at(const FieldPos(0, 24)), throwsRangeError);
  });

  test("mark(X, Y, V) & get(X, Y) equals V", () {
    final field = Field(2, 2)
      ..markX(const FieldPos(0, 0))
      ..markO(const FieldPos(1, 1));

    expect(field.at(const FieldPos(0, 0)), CellValue.X);
    expect(field.at(const FieldPos(1, 1)), CellValue.O);
  });

  test("mark(X, Y, V) & mark(X, Y, ANY) throws", () {
    final throwsFieldPosAlreadyMarkedException =
        throwsA(const TypeMatcher<FieldPosAlreadyMarkedException>());

    final field = Field(1, 1)..markX(const FieldPos(0, 0));

    expect(() => field.markO(const FieldPos(0, 0)),
        throwsFieldPosAlreadyMarkedException);
    expect(() => field.markX(const FieldPos(0, 0)),
        throwsFieldPosAlreadyMarkedException);
  });

  test("clear works", () {
    final field = Field(1, 1)
      ..markX(const FieldPos(0, 0))
      ..clear();

    expect(field.at(const FieldPos(0, 0)), null);
  });
}

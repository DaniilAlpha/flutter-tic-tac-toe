import "package:flutter_test/flutter_test.dart";
import "package:tic_tac_toe/core/domain/math.dart";

void main() {
  test("fact works", () {
    expect(fact(5), 120);
    expect(fact(1), 1);
    expect(fact(0), 1);
    expect(fact(double.infinity), double.infinity);
    expect(fact(double.nan).isNaN, true);
    expect(fact(-1).isNaN, true);
  });

  test("lg works", () {
    expect(lg(100), 2);
    expect(lg(1), 0);
    expect(lg(0), -double.infinity);
    expect(lg(double.nan).isNaN, true);
    expect(lg(-1).isNaN, true);
  });

  test("log works", () {
    expect(log(3, 9), 2);
    expect(log(3, 1), 0);
    expect(log(3, 0), -double.infinity);
    expect(log(0, 3), 0);
    expect(log(0, 0).isNaN, true);
    expect(log(1, 3), double.infinity);
    expect(log(-1, -1).isNaN, true);
    expect(log(3, -1).isNaN, true);
    expect(log(-1, 3).isNaN, true);
  });
}

// ignore_for_file: parameter_assignments

import "dart:ui" hide lerpDouble;

export "dart:ui" hide lerpDouble;

/// Linearly interpolate between two numbers, `a` and `b`, by an extrapolation
/// factor `t`.
///
/// When `a` and `b` are equal or both NaN, `a` is returned.  Otherwise,
/// `a`, `b`, and `t` are required to be finite or null, and the result of `a +
/// (b - a) * t` is returned, where nulls are defaulted to 0.0.
double lerpDouble(num? a, num? b, double t) {
  a ??= 0.0;
  b ??= 0.0;

  if (a == b || (a.isNaN && b.isNaN)) {
    return a.toDouble();
  }
  assert(a.isFinite, "Cannot interpolate between finite and non-finite values");
  assert(b.isFinite, "Cannot interpolate between finite and non-finite values");
  assert(t.isFinite, "t must be finite when interpolating between values");
  return a * (1.0 - t) + b * t;
}

Offset lerpOffset(Offset? a, Offset? b, double t) =>
    Offset(lerpDouble(a?.dx, b?.dx, t), lerpDouble(a?.dy, b?.dy, t));

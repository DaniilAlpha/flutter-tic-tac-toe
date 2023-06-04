import "dart:math" as math;
import "dart:math" hide log;

export "dart:math" hide log;

/// Random number generator.
final rng = Random();

/// Converts [x] to an [int] Returns the factorial of the value.
///
/// Returns positive infinity if [x] is equal to positive infinity.
/// Returns NaN if [x] is NaN or less than zero.
double fact(num x) {
  if (x < 0 || x.isNaN) {
    return double.nan;
  } else if (x.isInfinite) {
    return double.infinity;
  }

  var result = 1.0;
  for (var i = x.toInt(); i > 1; i--) {
    result *= i;
  }
  return result;
}

/// Converts [x] to a [double] and returns the natural logarithm of the value.
///
/// Returns negative infinity if [x] is equal to zero.
/// Returns NaN if [x] is NaN or less than zero.
const ln = math.log;

/// Converts [x] to a [double] and returns the common logarithm of the value.
///
/// Returns negative infinity if [x] is equal to zero.
/// Returns NaN if [x] is NaN or less than zero.
double lg(num x) => ln(x) / ln10;

/// Converts [x] and [a] to [double]s and returns the base [a] logarithm of the [x].
///
/// Returns negative infinity if [x] is equal to zero.
/// Returns zero if [a] is equal to zero.
/// Returns NaN if [a] and [x] both equal to zero.
/// Returns positive infinity if [a] is equal to one.
/// Returns NaN if [x] or [a] is NaN or less than zero.
double log(num a, num x) => ln(x) / ln(a);

import 'validator/nullable_validator.dart';

/// Ensures the number is greater than or equal to [min].
class MinValidator extends NullableValidator<num> {
  const MinValidator({
    required this.min,
    required super.error,
    super.ignoreEmptyValues,
  });

  /// The inclusive lower bound.
  final num min;

  @override
  bool isValid(num value) => value >= min;
}

/// Ensures the number is less than or equal to [max].
class MaxValidator extends NullableValidator<num> {
  const MaxValidator({
    required this.max,
    required super.error,
    super.ignoreEmptyValues,
  });

  /// The inclusive upper bound.
  final num max;

  @override
  bool isValid(num value) => value <= max;
}

/// Ensures the number is within the inclusive range [[min], [max]].
class BetweenValidator extends NullableValidator<num> {
  const BetweenValidator({
    required this.min,
    required this.max,
    required super.error,
    super.ignoreEmptyValues,
  });

  final num min;
  final num max;

  @override
  bool isValid(num value) => value >= min && value <= max;
}

/// Ensures the number is strictly greater than zero.
class PositiveValidator extends NullableValidator<num> {
  const PositiveValidator({required super.error, super.ignoreEmptyValues});

  @override
  bool isValid(num value) => value > 0;
}

/// Ensures the number is strictly less than zero.
class NegativeValidator extends NullableValidator<num> {
  const NegativeValidator({required super.error, super.ignoreEmptyValues});

  @override
  bool isValid(num value) => value < 0;
}

/// Ensures the number is a multiple of [factor].
///
/// A [factor] of `0` is always invalid (rather than dividing by zero).
///
/// The check is exact by default. Because `%` is imprecise for decimals
/// (`0.3 % 0.1 != 0`), pass a small [tolerance] (e.g. `1e-9`) when [factor] or
/// the values are non-integers.
class MultipleOfValidator extends NullableValidator<num> {
  const MultipleOfValidator({
    required this.factor,
    required super.error,
    this.tolerance = 0,
    super.ignoreEmptyValues,
  });

  /// The value must be a multiple of this.
  final num factor;

  /// Allowed floating-point slack around a multiple. Keep `0` for exact integer
  /// checks; raise it for decimal [factor]s.
  final num tolerance;

  @override
  bool isValid(num value) {
    if (factor == 0) {
      return false;
    }

    final step = factor.abs();
    final remainder = value % step;

    return remainder <= tolerance || (step - remainder) <= tolerance;
  }
}

/// Ensures the number is even (its remainder modulo 2 is zero).
///
/// A non-integer value (e.g. `4.5`) is neither even nor odd and fails.
class EvenValidator extends NullableValidator<num> {
  const EvenValidator({required super.error, super.ignoreEmptyValues});

  @override
  bool isValid(num value) => value % 2 == 0;
}

/// Ensures the number is odd (its remainder modulo 2 is one).
///
/// A non-integer value (e.g. `4.5`) is neither even nor odd and fails.
class OddValidator extends NullableValidator<num> {
  const OddValidator({required super.error, super.ignoreEmptyValues});

  @override
  bool isValid(num value) => value % 2 == 1;
}

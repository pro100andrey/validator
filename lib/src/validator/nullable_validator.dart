import 'validator.dart';

/// Base class for validators over a nullable, non-`String` value such as [num]
/// or [DateTime].
///
/// Mirrors the "optional input skips its check" convention used by text
/// validators: when [ignoreEmptyValues] is `true` (the default) a `null` value
/// is treated as valid and [isValid] is not called. Set it to `false` to reject
/// `null` as well. There is no "empty" concept for these values — for a
/// non-text validator, "empty" means `null`.
abstract class NullableValidator<T extends Object> extends Validator<T> {
  /// Constructs a validator that skips `null` unless [ignoreEmptyValues] is
  /// `false`.
  const NullableValidator({
    required super.error,
    this.ignoreEmptyValues = true,
  });

  /// Whether a `null` value short-circuits to "valid".
  final bool ignoreEmptyValues;

  @override
  String? call(T? value) =>
      value == null ? (ignoreEmptyValues ? null : error) : super(value);
}

/// Groups [NullableValidator]s of the same type [T] and runs them in order.
///
/// The typed analogue of `MultiValidator` (which groups text validators): it
/// returns the error of the **first** failing validator, or `null` when every
/// one passes. Use [errors] to collect every failing message. Build one with
/// the `&` operator or directly.
///
/// ```dart
/// final adult = const MinValidator(min: 18, error: 'Too young') &
///     const PositiveValidator(error: 'Must be positive');
/// adult(20); // null
/// adult(-1); // 'Must be positive'
/// ```
class ValidatorGroup<T extends Object> {
  /// Constructs a group from the given [validators].
  const ValidatorGroup(this.validators);

  /// The validators applied to the value, in order.
  final List<NullableValidator<T>> validators;

  /// Returns the error of the first failing validator, or `null` if the value
  /// satisfies every validator.
  String? call(T? value) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) {
        return error;
      }
    }

    return null;
  }

  /// Runs every validator and returns the errors of all that failed.
  ///
  /// Returns an empty list when the value is valid.
  List<String> errors(T? value) => [
    for (final validator in validators) ?validator(value),
  ];

  /// Appends [other] to this group, returning a new [ValidatorGroup].
  ValidatorGroup<T> operator &(NullableValidator<T> other) =>
      ValidatorGroup([...validators, other]);
}

/// Composition sugar for building a [ValidatorGroup] with the `&` operator.
///
/// ```dart
/// final age = const MinValidator(min: 18, error: 'Too young') &
///     const MaxValidator(max: 120, error: 'Too old');
/// ```
extension NullableValidatorComposition<T extends Object>
    on NullableValidator<T> {
  /// Combines this validator with [other]; the result reports the first error.
  ValidatorGroup<T> operator &(NullableValidator<T> other) =>
      ValidatorGroup([this, other]);
}

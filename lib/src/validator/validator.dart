import 'package:meta/meta.dart';

/// Base class for every validator in the package.
///
/// A validator checks a single nullable value and reports at most one error:
/// calling it returns `null` when the value is acceptable, or [error] when it
/// is not. `Validator<String>` matches Flutter's `FormFieldValidator<String>`,
/// so an instance can be passed straight to a `TextFormField.validator`.
///
/// ## Empty handling
///
/// "Empty" input — `null`, plus whatever [isEmpty] recognises for the value
/// type (for text: blank strings) — is handled once, here in [call]:
///
/// - when [ignoreEmptyValues] is `true` (the default) empty input is skipped
///   and treated as valid, so an *optional* field never reports a format
///   error when left blank;
/// - when it is `false`, empty input fails with [error] straight away.
///
/// Concrete validators therefore only implement [isValid] for a real,
/// non-empty value and never deal with `null`.
///
/// Example:
/// ```dart
/// class PositiveValidator extends Validator<num> {
///   const PositiveValidator({required super.error, super.ignoreEmptyValues});
///
///   @override
///   bool isValid(num value) => value > 0;
/// }
///
/// const positive = PositiveValidator(error: 'Must be positive');
/// positive(2);    // null
/// positive(-1);   // 'Must be positive'
/// positive(null); // null — empty input is skipped by default
/// ```
abstract class Validator<T extends Object> {
  /// Constructs a validator that reports [error] on failure.
  ///
  /// When [ignoreEmptyValues] is `true` (the default) empty input is treated
  /// as valid and [isValid] is not called. Set it to `false` to make empty
  /// input fail with [error] instead.
  const Validator({
    required this.error,
    this.ignoreEmptyValues = true,
  });

  /// The error message returned when validation fails.
  final String error;

  /// Whether empty input (see [isEmpty]) short-circuits to "valid".
  final bool ignoreEmptyValues;

  /// Whether a non-null [value] counts as "empty" for this value type.
  ///
  /// The base implementation treats no non-null value as empty, so only
  /// `null` is skipped. Text validators override this to also treat blank
  /// strings as empty.
  @protected
  bool isEmpty(T value) => false;

  /// Checks whether a non-empty [value] satisfies the validation criteria.
  ///
  /// Override this in subclasses with the specific validation logic. It is
  /// never called with empty input — [call] resolves that beforehand.
  bool isValid(T value);

  /// Validates [value]: returns `null` when it is acceptable, [error] when
  /// it is not.
  ///
  /// Empty input (`null` or [isEmpty]) is resolved here according to
  /// [ignoreEmptyValues]; anything else is delegated to [isValid].
  String? call(T? value) {
    if (value == null || isEmpty(value)) {
      return ignoreEmptyValues ? null : error;
    }

    return isValid(value) ? null : error;
  }
}

/// Groups several validators of the same type [T] and runs them in order.
///
/// By default it behaves like a short-circuiting form validator: it returns
/// the error of the **first** validator that fails, or `null` when every
/// validator passes. Use [errors] when you need every failing message at
/// once. Build one directly or with the `&` operator.
///
/// ```dart
/// const password = ValidatorGroup([
///   RequiredValidator(error: 'Required'),
///   MinLengthValidator(min: 8, error: 'At least 8 characters'),
///   HasUppercaseValidator(error: 'Add an uppercase letter'),
/// ]);
///
/// password('abc');       // 'At least 8 characters'
/// password.errors('abc'); // ['At least 8 characters', 'Add an uppercase…']
/// password('Abcdefghi'); // null
/// ```
class ValidatorGroup<T extends Object> {
  /// Constructs a group from the given [validators].
  const ValidatorGroup(this.validators);

  /// The validators applied to the value, in order.
  final List<Validator<T>> validators;

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
  /// Returns an empty list when the value is valid. Useful for showing a full
  /// checklist of requirements (e.g. password rules) rather than one message.
  List<String> errors(T? value) => [
    for (final validator in validators) ?validator(value),
  ];

  /// Appends [other] to this group, returning a new [ValidatorGroup].
  ValidatorGroup<T> operator &(Validator<T> other) =>
      ValidatorGroup([...validators, other]);
}

/// Composition sugar for building a [ValidatorGroup] with the `&` operator.
///
/// ```dart
/// final password = const RequiredValidator(error: 'Required') &
///     const MinLengthValidator(min: 8, error: 'At least 8 characters');
///
/// password('Abcdefgh'); // null
/// ```
extension ValidatorComposition<T extends Object> on Validator<T> {
  /// Combines this validator with [other]; the result reports the first error.
  ValidatorGroup<T> operator &(Validator<T> other) =>
      ValidatorGroup([this, other]);
}

/// A special validator that checks whether two values are equal.
///
/// Useful for confirmation fields, e.g. "password" and "confirm password".
///
/// Equality is compared with `==`, so two distinct [String] instances that
/// hold the same characters are considered a match.
///
/// Example:
/// ```dart
/// final match = MatchValidator(error: 'Passwords do not match');
/// print(match('secret', 'secret')); // null
/// print(match('secret', 'other'));  // 'Passwords do not match'
/// ```
class MatchValidator {
  /// Constructs a match validator with the specified [error] message.
  const MatchValidator({required this.error});

  /// The error message returned when the two values are not equal.
  final String error;

  /// Returns `null` when [v1] equals [v2], otherwise returns [error].
  String? call(Object? v1, Object? v2) => v1 == v2 ? null : error;
}

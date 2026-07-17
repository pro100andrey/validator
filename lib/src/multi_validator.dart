import 'text_validator.dart';

/// Groups several [TextValidator]s together and runs them in order.
///
/// By default it behaves like a short-circuiting form validator: it returns the
/// error of the **first** validator that fails, or `null` when every validator
/// passes. Use [errors] when you need every failing message at once.
///
/// Example:
/// ```dart
/// const password = MultiValidator(
///   validators: [
///     RequiredValidator(error: 'Required'),
///     MinLengthValidator(min: 8, error: 'At least 8 characters'),
///     HasUppercaseValidator(error: 'Add an uppercase letter'),
///   ],
/// );
///
/// password('abc');       // 'At least 8 characters'
/// password('abcdefghi'); // 'Add an uppercase letter'
/// password('Abcdefghi'); // null
/// ```
class MultiValidator {
  /// Constructs a validator group from the given [validators].
  const MultiValidator({required this.validators});

  /// The validators applied to the value, in order.
  ///
  /// Restricted to [TextValidator] by design: the group forwards `null`/empty
  /// input and relies on each member's empty-handling, which a plain
  /// `Validator<String>` (whose `call` takes a non-null `String`) does not
  /// provide.
  final List<TextValidator> validators;

  /// Returns the error of the first failing validator, or `null` if the value
  /// satisfies every validator.
  String? call(String? value) {
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
  List<String> errors(String? value) => [
    for (final validator in validators) ?validator(value),
  ];

  /// Appends [other] to this group, returning a new [MultiValidator].
  MultiValidator operator &(TextValidator other) =>
      MultiValidator(validators: [...validators, other]);
}

/// Composition sugar for building a [MultiValidator] with the `&` operator.
///
/// ```dart
/// final password = RequiredValidator(error: 'Required') &
///     MinLengthValidator(min: 8, error: 'At least 8 characters') &
///     HasUppercaseValidator(error: 'Add an uppercase letter');
///
/// password('Abcdefgh'); // null
/// ```
extension TextValidatorComposition on TextValidator {
  /// Combines this validator with [other]; the result reports the first error.
  MultiValidator operator &(TextValidator other) =>
      MultiValidator(validators: [this, other]);
}

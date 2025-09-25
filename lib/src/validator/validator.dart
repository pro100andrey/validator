/// Abstract base class for creating validators that check input values
/// against specific conditions.
///
/// This class serves as the foundation for building both simple and
/// complex validation logic. It ensures consistency in how errors are
/// reported and conditions are validated.
///
/// Example usage:
/// ```dart
/// class NonEmptyValidator extends Validator<String> {
///   const NonEmptyValidator({required super.error});
///
///   @override
///   bool isValid(String value) => value.trim().isNotEmpty;
/// }
///
/// final validator = NonEmptyValidator(error: 'Value cannot be empty');
/// print(validator('')); // Output: 'Value cannot be empty'
/// print(validator('Hello')); // Output: null
/// ```
abstract class Validator<T> {
  /// Constructs a validator with the specified error message.
  ///
  /// The [error] is the message that will be returned if validation fails.
  const Validator({required this.error});

  /// The error message to display when the validation fails.
  ///
  /// This message should be descriptive enough to guide users to correct
  /// the input.
  final String error;

  /// Checks if the given [value] satisfies the validation criteria.
  ///
  /// This method must be overridden in subclasses to define the specific
  /// validation logic.
  ///
  /// Returns `true` if the [value] is valid, otherwise `false`.
  bool isValid(T value);

  /// A callable function to validate the input.
  ///
  /// This function is syntactic sugar to allow instances of the class
  /// to be used like a function. It simplifies usage in validation workflows.
  ///
  /// - If the input is valid, returns `null`.
  /// - If the input is invalid, returns the [error] message.
  ///
  /// Example:
  /// ```dart
  /// final validator = NonEmptyValidator(error: 'Cannot be empty');
  /// final result = validator(''); // Calls the `call` method internally.
  /// print(result); // Output: 'Cannot be empty'
  /// ```
  String? call(T value) => isValid(value) ? null : error;
}

/// Group together and validate the basic validators.
class MultiValidator {
  const MultiValidator({required this.validators});

  final List<Validator> validators;

  String? call(String? value) {
    for (final validator in validators) {
      if (validator(value) != null) {
        return validator.error;
      }
    }

    return null;
  }
}

/// A special match validator to check if the v1 equals v2 value.
class MatchValidator {
  MatchValidator({
    required this.error,
  });

  final String error;

  String? call(Object? v1, Object? v2) => identical(v1, v2) ? null : error;
}

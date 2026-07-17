/// A special validator that checks whether two values are equal.
///
/// Useful for confirmation fields, e.g. "password" and "confirm password".
/// It sits outside the [Object]-typed `Validator<T>` hierarchy because it
/// compares **two** values instead of checking one.
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

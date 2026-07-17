import 'text_validator.dart';

/// Ensures the value is one of the allowed [values].
///
/// Useful for constrained inputs such as country codes, currencies or any
/// enum-like field. Set [caseSensitive] to `false` to match regardless of case.
///
/// Example:
/// ```dart
/// const currency = OneOfValidator(
///   values: ['USD', 'EUR', 'UAH'],
///   error: 'Unsupported currency',
/// );
/// ```
class OneOfValidator extends TextValidator {
  const OneOfValidator({
    required this.values,
    required super.error,
    this.caseSensitive = true,
    super.ignoreEmptyValues,
  });

  /// The set of accepted values.
  final List<String> values;

  /// Whether the comparison is case-sensitive.
  final bool caseSensitive;

  @override
  bool isValid(String value) {
    if (caseSensitive) {
      return values.contains(value);
    }

    final lower = value.toLowerCase();

    return values.any((v) => v.toLowerCase() == lower);
  }
}

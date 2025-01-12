import '../pro_validator.dart';

/// Modes for handling empty values in validators.
enum EmptyValueMode {
  /// Ignore empty values entirely.
  ignore,

  /// Treat empty values as valid.
  valid,

  /// Treat empty values as invalid.
  invalid,
}

abstract class TextValidator extends Validator<String> {
  const TextValidator({
    required super.error,
    this.emptyValueMode = EmptyValueMode.ignore,
  });

  final EmptyValueMode emptyValueMode;

  @override
  String? call(String? value) {
    final toTest = value ?? '';

    if (toTest.isEmpty) {
      switch (emptyValueMode) {
        case EmptyValueMode.ignore:
          return null; // Skip validation for empty values

        case EmptyValueMode.valid:
          return null; // Consider empty values as valid

        case EmptyValueMode.invalid:
          return error; // Consider empty values as invalid
      }
    }

    return super(toTest);
  }

  /// Method to check if an input matches a given pattern
  bool hasMatch(
    String pattern,
    String input, {
    bool caseSensitive = true,
  }) =>
      RegExp(pattern, caseSensitive: caseSensitive).hasMatch(input);
}

class RequiredValidator extends TextValidator {
  const RequiredValidator({
    required super.error,
    super.emptyValueMode,
  });

  @override
  bool isValid(String value) => value.trim().isNotEmpty;
}

class MaxLengthValidator extends TextValidator {
  const MaxLengthValidator({
    required this.max,
    required super.error,
    super.emptyValueMode,
  });

  final int max;

  @override
  bool isValid(String value) => value.length <= max;
}

class MinLengthValidator extends TextValidator {
  const MinLengthValidator({
    required this.min,
    required super.error,
    super.emptyValueMode,
  });

  final int min;

  @override
  bool isValid(String value) => value.length >= min;
}

class HasUppercaseValidator extends TextValidator {
  const HasUppercaseValidator({
    required super.error,
    super.emptyValueMode,
  });

  /// Regex pattern to validate uppercase characters.
  static const _pattern = '[A-Z]';

  @override
  bool isValid(String value) => hasMatch(
        _pattern,
        value,
      );
}

class HasLowercaseValidator extends TextValidator {
  const HasLowercaseValidator({
    required super.error,
    super.emptyValueMode,
  });

  /// Regex pattern to validate lowercase characters
  static const _pattern = '[a-z]';

  @override
  bool isValid(String value) => hasMatch(
        _pattern,
        value,
      );
}

class HasANumberValidator extends TextValidator {
  const HasANumberValidator({
    required super.error,
    super.emptyValueMode,
  });

  /// Regex pattern to validate lowercase characters.
  static const _pattern = '[0-9]';

  @override
  bool isValid(String value) => hasMatch(
        _pattern,
        value,
      );
}

class LengthRangeValidator extends TextValidator {
  const LengthRangeValidator({
    required this.min,
    required this.max,
    required super.error,
    super.emptyValueMode,
  });

  final int min;
  final int max;

  @override
  bool isValid(String value) => value.length >= min && value.length <= max;
}

class NumRangeValidator extends TextValidator {
  const NumRangeValidator({
    required this.min,
    required this.max,
    required super.error,
    super.emptyValueMode,
  });

  final num min;
  final num max;

  @override
  bool isValid(String value) {
    final numericValue = num.tryParse(value);
    if (numericValue == null) {
      return false;
    }

    return numericValue >= min && numericValue <= max;
  }
}

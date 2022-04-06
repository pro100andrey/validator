library validator;

abstract class Validator<T> {
  Validator(this.error);

  /// The error to display when the validation fails
  final String error;

  /// Checks the input against the given conditions
  bool isValid(T value);

  /// Call is a special function that makes a class callable
  /// returns null if the input is valid otherwise it returns the provided error
  String? call(T value) => isValid(value) ? null : error;
}

abstract class TextValidator extends Validator<String?> {
  TextValidator(String error) : super(error);

  // Returns false if you want the validator to return error
  // message when the value is empty.
  bool get ignoreEmptyValues => true;

  @override
  String? call(String? value) {
    if (value == null) {
      return null;
    }

    return (value.isEmpty && ignoreEmptyValues) ? null : super(value);
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
  RequiredValidator({
    required String error,
  }) : super(error);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) => value != null && value.isNotEmpty;
}

class MaxLengthValidator extends TextValidator {
  MaxLengthValidator(
    this.max, {
    required String error,
  }) : super(error);

  final int max;

  @override
  bool isValid(String? value) => value!.length <= max;
}

class MinLengthValidator extends TextValidator {
  MinLengthValidator(
    this.min, {
    required String error,
  }) : super(error);

  final int min;

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) => value!.length >= min;
}

class MinOneUppercaseValidator extends TextValidator {
  MinOneUppercaseValidator({
    required String error,
  }) : super(error);

  /// Regex pattern to validate uppercase characters.
  static const _pattern = '[A-Z]';

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) => hasMatch(
        _pattern,
        value!,
      );
}

class MinOneLowercaseValidator extends TextValidator {
  MinOneLowercaseValidator({
    required String error,
  }) : super(error);

  /// Regex pattern to validate lowercase characters
  static const _pattern = '[a-z]';

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) => hasMatch(
        _pattern,
        value!,
      );
}

class HasANumberValidator extends TextValidator {
  HasANumberValidator({
    required String error,
  }) : super(error);

  /// Regex pattern to validate lowercase characters.
  static const _pattern = '[0-9]';

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) => hasMatch(
        _pattern,
        value!,
      );
}

class LengthRangeValidator extends TextValidator {
  LengthRangeValidator({
    required this.min,
    required this.max,
    required String error,
  }) : super(error);

  final int min;
  final int max;

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) => value!.length >= min && value.length <= max;
}

class NumRangeValidator extends TextValidator {
  NumRangeValidator({
    required this.min,
    required this.max,
    required String error,
  }) : super(error);

  final num min;
  final num max;

  @override
  bool isValid(String? value) {
    final numericValue = num.tryParse(value!);
    if (numericValue == null) {
      return false;
    }

    return numericValue >= min && numericValue <= max;
  }
}

class EmailValidator extends TextValidator {
  EmailValidator({
    required String error,
  }) : super(error);

  /// Regex pattern to validate email string.
  static const _emailPattern =
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";

  @override
  bool isValid(String? value) => hasMatch(
        _emailPattern,
        value!,
        caseSensitive: false,
      );
}

class PhoneValidator extends TextValidator {
  PhoneValidator({
    required String error,
  }) : super(error);

  /// Regex pattern to validate phone string.
  static const _regex =
      r'([0-9\s\-]{7,})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$';

  @override
  bool isValid(String? value) => hasMatch(
        _regex,
        value!,
        caseSensitive: false,
      );
}

class UrlValidator extends TextValidator {
  UrlValidator({
    required String error,
  }) : super(error);

  /// Regex pattern to validate url string.
  static const _regex =
      r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})';

  @override
  bool isValid(String? value) => hasMatch(
        _regex,
        value!,
        caseSensitive: false,
      );
}

class PatternValidator extends TextValidator {
  PatternValidator(
    this.pattern, {
    required String error,
    this.caseSensitive = true,
  }) : super(error);

  final Pattern pattern;
  final bool caseSensitive;

  @override
  bool isValid(String? value) => hasMatch(
        pattern.toString(),
        value!,
        caseSensitive: caseSensitive,
      );
}

/// A special match validator to check if the v1 equals v2 value.
class MatchValidator {
  MatchValidator({
    required this.error,
  });

  final String error;

  String? validateMatch(String v1, String v2) => v1 == v2 ? null : error;
}

/// [GroupValidator] Group together and validate the basic validators.
class GroupValidator {
  GroupValidator(this.validators);

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

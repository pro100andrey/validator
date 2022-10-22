library pro_validator;

abstract class Validator<T> {
  const Validator({required this.error});

  /// The error to display when the validation fails
  final String error;

  /// Checks the input against the given conditions
  bool isValid(T value);

  /// Call is a special function that makes a class callable
  /// returns null if the input is valid otherwise it returns the provided error
  String? call(T value) => isValid(value) ? null : error;
}

abstract class TextValidator extends Validator<String?> {
  const TextValidator({required super.error});

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

/// Ensures the value is not empty, not white space only.
class RequiredValidator extends TextValidator {
  const RequiredValidator({
    required super.error,
  });

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) => value != null && value.trim().isNotEmpty;
}

/// Ensures the value length contains no more than a set number of characters.
class MaxLengthValidator extends TextValidator {
  const MaxLengthValidator({
    required this.max,
    required super.error,
  });

  final int max;

  @override
  bool isValid(String? value) => value!.length <= max;
}

/// Ensures the value length contains no fewer than a set number of characters.
class MinLengthValidator extends TextValidator {
  const MinLengthValidator({
    required this.min,
    required super.error,
  });

  final int min;

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) => value!.length >= min;
}

/// Ensures the value contains a minimum of one uppercase character.
class HasUppercaseValidator extends TextValidator {
  const HasUppercaseValidator({
    required super.error,
  });

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

/// Ensures the value contains a minimum of one lowercase character.
class HasLowercaseValidator extends TextValidator {
  const HasLowercaseValidator({
    required super.error,
  });

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

/// Ensures the value contains a minimum of one numeric character.
class HasANumberValidator extends TextValidator {
  const HasANumberValidator({
    required super.error,
  });

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

/// Ensures the value length is contained in the range [min, max].
class LengthRangeValidator extends TextValidator {
  const LengthRangeValidator({
    required this.min,
    required this.max,
    required super.error,
  });

  final int min;
  final int max;

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) => value!.length >= min && value.length <= max;
}

/// Ensures the num value is contained in the range [min, max].
class NumRangeValidator extends TextValidator {
  const NumRangeValidator({
    required this.min,
    required this.max,
    required super.error,
  });

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

/// Ensures the value is a validly formatted email address.
class EmailValidator extends TextValidator {
  const EmailValidator({
    required super.error,
  });

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

/// Ensures the value is a validly formatted phone number.
class PhoneValidator extends TextValidator {
  const PhoneValidator({
    required super.error,
  });

  /// Regex pattern to validate phone string.
  static const _regex =
      r'^([+]?[\s0-9]+)?(\d{3}|[(]?[0-9]+[)])?([-]?[\s]?[0-9])+$';

  @override
  bool isValid(String? value) => hasMatch(
        _regex,
        value!,
        caseSensitive: false,
      );
}

/// Ensures the value is a validly formatted URL.
class UrlValidator extends TextValidator {
  const UrlValidator({
    required super.error,
  });

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

/// Ensures a custom regular expression string.
class PatternValidator extends TextValidator {
  PatternValidator({
    required this.pattern,
    required super.error,
    this.caseSensitive = true,
  });

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

  String? call(String? v1, String? v2) => v1 == v2 ? null : error;
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

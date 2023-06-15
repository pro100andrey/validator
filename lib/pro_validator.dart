/// pro_validator is a dart package that provides a set of validators
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

abstract class TextValidator extends Validator<String> {
  const TextValidator({
    required super.error,
    this.ignoreEmptyValues = false,
  });

  /// If true, empty values will be ignored
  final bool ignoreEmptyValues;

  @override
  String? call(String? value) {
    final toTest = value ?? '';

    return (toTest.isEmpty && ignoreEmptyValues) ? null : super(toTest);
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
    super.ignoreEmptyValues,
  });

  @override
  bool isValid(String value) => value.trim().isNotEmpty;
}

/// Ensures the value length contains no more than a set number of characters.
class MaxLengthValidator extends TextValidator {
  const MaxLengthValidator({
    required this.max,
    required super.error,
    super.ignoreEmptyValues,
  });

  final int max;

  @override
  bool isValid(String value) => value.length <= max;
}

/// Ensures the value length contains no fewer than a set number of characters.
class MinLengthValidator extends TextValidator {
  const MinLengthValidator({
    required this.min,
    required super.error,
    super.ignoreEmptyValues,
  });

  final int min;

  @override
  bool isValid(String value) => value.length >= min;
}

/// Ensures the value contains a minimum of one uppercase character.
class HasUppercaseValidator extends TextValidator {
  const HasUppercaseValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Regex pattern to validate uppercase characters.
  static const _pattern = '[A-Z]';

  @override
  bool isValid(String value) => hasMatch(
        _pattern,
        value,
      );
}

/// Ensures the value contains a minimum of one lowercase character.
class HasLowercaseValidator extends TextValidator {
  const HasLowercaseValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Regex pattern to validate lowercase characters
  static const _pattern = '[a-z]';

  @override
  bool isValid(String value) => hasMatch(
        _pattern,
        value,
      );
}

/// Ensures the value contains a minimum of one numeric character.
class HasANumberValidator extends TextValidator {
  const HasANumberValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Regex pattern to validate lowercase characters.
  static const _pattern = '[0-9]';

  @override
  bool isValid(String value) => hasMatch(
        _pattern,
        value,
      );
}

/// Ensures the value length is contained in the range [min, max].
class LengthRangeValidator extends TextValidator {
  const LengthRangeValidator({
    required this.min,
    required this.max,
    required super.error,
    super.ignoreEmptyValues,
  });

  final int min;
  final int max;

  @override
  bool isValid(String value) => value.length >= min && value.length <= max;
}

/// Ensures the num value is contained in the range [min, max].
class NumRangeValidator extends TextValidator {
  const NumRangeValidator({
    required this.min,
    required this.max,
    required super.error,
    super.ignoreEmptyValues,
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

/// Ensures the value is a validly formatted email address.
class EmailValidator extends TextValidator {
  const EmailValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Regex pattern to validate email string.
  static const _emailPattern =
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";

  @override
  bool isValid(String value) => hasMatch(
        _emailPattern,
        value,
        caseSensitive: false,
      );
}

/// Ensures the value is a validly formatted phone number.
class PhoneValidator extends TextValidator {
  const PhoneValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Regex pattern to validate phone string.
  static const _regex =
      r'^([+]?[\s0-9]+)?(\d{3}|[(]?[0-9]+[)])?([-]?[\s]?[0-9])+$';

  @override
  bool isValid(String value) => hasMatch(
        _regex,
        value,
        caseSensitive: false,
      );
}

/// Ensures the value is a validly formatted credit card number.
class CreditCardValidator extends TextValidator {
  const CreditCardValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Regex pattern to validate credit card string.
  ///
  /// - `Visa` - numbers start with a 4. New cards have 16 digits. Old cards
  /// have 13.
  /// - `MasterCard` numbers either start with the numbers 51 through 55 or with
  /// the numbers 2221 through 2720. All have 16 digits.
  /// `American Express` Credit Card Number (CCN) is a 15-digit number starting
  /// with 34 or 37 and might have dashes (hyphens) or spaces as separators.
  /// For example, NNNN-NNNNNN-NNNNN or NNNN NNNNNN NNNNN.
  /// `Diners Club` - is a 14-digit number beginning with 300–305, 36, 38, or 39
  /// and might have dashes (hyphens) or spaces as separators.
  /// For example, NNNN-NNNNNN-NNNN or NNNN NNNNNN NNNN.
  /// `Discover`- is a 16-digit number beginning with 6011, 644–649 or 65 and
  /// might have dashes (hyphens) or spaces as separators.
  /// For example, NNNN-NNNN-NNNN-NNNN or NNNN NNNN NNNN NNNN.
  /// `JCB` - JCB CCN is a 16-digit number beginning with 3528 or 3589 and might
  /// have dashes (hyphens) or spaces as separators.
  /// For example, NNNN-NNNN-NNNN-NNNN or NNNN NNNN NNNNNNNN.
  static const _regex = '^('
      '?:4[0-9]{12}(?:[0-9]{3})?' // Visa
      '|(?:5[1-5][0-9]{2}' // MasterCard
      '|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}'
      '|3[47][0-9]{13}' // American Express
      '|3(?:0[0-5]|[68][0-9])[0-9]{11}' // Diners Club
      '|6(?:011|5[0-9]{2})[0-9]{12}' // Discover
      '|(?:2131|1800|35[0-9]{3})[0-9]{11}' // JCB
      r')$';

  @override
  bool isValid(String value) {
    final sanitized = value.replaceAll(RegExp('[^0-9]+'), '');
    return hasMatch(
      _regex,
      sanitized,
      caseSensitive: false,
    );
  }
}

/// Ensures the value is a validly formatted URL.
class UrlValidator extends TextValidator {
  const UrlValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Regex pattern to validate url string.
  static const _regex =
      r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})';

  @override
  bool isValid(String value) => hasMatch(
        _regex,
        value,
        caseSensitive: false,
      );
}

/// Ensures a custom regular expression string.
class PatternValidator extends TextValidator {
  PatternValidator({
    required this.pattern,
    required super.error,
    this.caseSensitive = true,
    super.ignoreEmptyValues,
  });

  final Pattern pattern;
  final bool caseSensitive;

  @override
  bool isValid(String value) => hasMatch(
        pattern.toString(),
        value,
        caseSensitive: caseSensitive,
      );
}

/// A special match validator to check if the v1 equals v2 value.
class MatchValidator {
  MatchValidator({
    required this.error,
  });

  final String error;

  String? call(Object? v1, Object? v2) => identical(v1, v2) ? null : error;
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

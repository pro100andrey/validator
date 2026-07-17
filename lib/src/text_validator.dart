import 'validator/validator.dart';

/// Base class for validators that operate on optional text (`String?`).
///
/// It refines the base [Validator]'s notion of "empty": for text, `null`,
/// empty and whitespace-only strings all count as empty, so an optional field
/// never reports a format error when "left blank". Concrete validators only
/// implement [isValid] for a real, non-blank value.
///
/// By convention, checking that a field is filled in is the job of
/// [RequiredValidator] alone. Every other text validator ignores empty input
/// by default ([ignoreEmptyValues] is `true`), so an empty field reports at
/// most one error. Combine them in a [ValidatorGroup] to require *and*
/// format-check:
///
/// ```dart
/// const email = ValidatorGroup([
///   RequiredValidator(error: 'Required'),
///   EmailValidator(error: 'Invalid email'),
/// ]);
/// email(null); // 'Required' — not 'Invalid email'
/// ```
abstract class TextValidator extends Validator<String> {
  /// Constructs a text validator.
  ///
  /// When [ignoreEmptyValues] is `true` (the default) a `null`, empty or
  /// whitespace-only value is treated as valid and [isValid] is not called.
  /// Set it to `false` to make such input fail with [error] instead (as
  /// [RequiredValidator] does).
  const TextValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Treats whitespace-only input as blank so an optional field never reports
  /// a format error when "left blank". Trimming only gates the skip; the raw
  /// value is still what [isValid] receives.
  @override
  bool isEmpty(String value) => value.trim().isEmpty;
}

/// Ensures the value is not empty and not whitespace only.
class RequiredValidator extends TextValidator {
  /// Constructs a required validator. Empty and `null` input always fail.
  const RequiredValidator({required super.error})
    : super(ignoreEmptyValues: false);

  @override
  bool isValid(String value) => value.trim().isNotEmpty;
}

/// Ensures the value contains no more than [max] characters.
class MaxLengthValidator extends TextValidator {
  const MaxLengthValidator({
    required this.max,
    required super.error,
    super.ignoreEmptyValues,
  });

  final int max;

  @override
  bool isValid(String value) => value.runes.length <= max;
}

/// Ensures the value contains no fewer than [min] characters.
class MinLengthValidator extends TextValidator {
  const MinLengthValidator({
    required this.min,
    required super.error,
    super.ignoreEmptyValues,
  });

  final int min;

  @override
  bool isValid(String value) => value.runes.length >= min;
}

/// Ensures the value contains at least one uppercase character.
class HasUppercaseValidator extends TextValidator {
  const HasUppercaseValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Regex matching any Unicode uppercase letter, compiled once.
  static final _pattern = RegExp(r'\p{Lu}', unicode: true);

  @override
  bool isValid(String value) => _pattern.hasMatch(value);
}

/// Ensures the value contains at least one lowercase character.
class HasLowercaseValidator extends TextValidator {
  const HasLowercaseValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Regex matching any Unicode lowercase letter, compiled once.
  static final _pattern = RegExp(r'\p{Ll}', unicode: true);

  @override
  bool isValid(String value) => _pattern.hasMatch(value);
}

/// Ensures the value contains at least one numeric character.
class HasANumberValidator extends TextValidator {
  const HasANumberValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Regex matching a numeric character, compiled once.
  static final _pattern = RegExp('[0-9]');

  @override
  bool isValid(String value) => _pattern.hasMatch(value);
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
  bool isValid(String value) {
    final length = value.runes.length;

    return length >= min && length <= max;
  }
}

/// Ensures the numeric value of the input is contained in the range [min, max].
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
    final numericValue = num.tryParse(value.trim());
    if (numericValue == null) {
      return false;
    }

    return numericValue >= min && numericValue <= max;
  }
}

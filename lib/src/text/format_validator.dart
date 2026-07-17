import '../string/checkers.dart';
import 'text_validator.dart';

/// Base class for validators backed by a regular expression.
///
/// Extend it to build reusable named validators, or use the ready-made
/// [PatternValidator] for one-off custom patterns.
abstract class PatternTextValidator extends TextValidator {
  /// Matches against a regex [pattern] source, compiled once (cached) with
  /// [caseSensitive].
  const PatternTextValidator({
    required super.error,
    required this.pattern,
    this.caseSensitive = true,
    super.ignoreEmptyValues,
  }) : _regExp = null;

  /// Matches against a pre-compiled [regExp].
  ///
  /// Use this when you need regex flags beyond case-sensitivity (`multiLine`,
  /// `dotAll`, `unicode`, …) or want to reuse a caller-owned [RegExp] instance
  /// instead of a source string.
  PatternTextValidator.fromRegExp(
    RegExp regExp, {
    required super.error,
    super.ignoreEmptyValues,
  }) : pattern = regExp.pattern,
       caseSensitive = regExp.isCaseSensitive,
       _regExp = regExp;

  /// The regular expression source the value is matched against.
  ///
  /// When built via [PatternTextValidator.fromRegExp] this mirrors the compiled
  /// regex's [RegExp.pattern].
  final String pattern;

  /// Whether the match is case-sensitive.
  final bool caseSensitive;

  /// A caller-provided compiled regex when built via
  /// [PatternTextValidator.fromRegExp]; otherwise `null`.
  final RegExp? _regExp;

  /// Compiled regexes shared across instances, keyed by `(caseSensitive,
  /// pattern)`, so each string pattern is compiled once instead of on every
  /// [isValid] call.
  static final _cache = <(bool, String), RegExp>{};

  RegExp get _effectiveRegExp =>
      _regExp ??
      _cache.putIfAbsent(
        (caseSensitive, pattern),
        () => RegExp(pattern, caseSensitive: caseSensitive),
      );

  @override
  bool isValid(String value) => _effectiveRegExp.hasMatch(value);
}

/// Ensures the value matches a custom regular expression.
///
/// Example:
/// ```dart
/// final hex = PatternValidator(
///   pattern: r'^#[0-9a-fA-F]{6}$',
///   error: 'Not a hex color',
/// );
/// ```
class PatternValidator extends PatternTextValidator {
  const PatternValidator({
    required super.pattern,
    required super.error,
    super.caseSensitive,
    super.ignoreEmptyValues,
  });

  /// Builds a validator from a pre-compiled [regExp], preserving all of its
  /// flags (case-sensitivity, `multiLine`, `dotAll`, `unicode`, …).
  ///
  /// ```dart
  /// final letters = PatternValidator.fromRegExp(
  ///   RegExp(r'^\p{L}+$', unicode: true),
  ///   error: 'Letters only',
  /// );
  /// ```
  PatternValidator.fromRegExp(
    super.regExp, {
    required super.error,
    super.ignoreEmptyValues,
  }) : super.fromRegExp();
}

/// Ensures the value is a validly formatted email address.
class EmailValidator extends TextValidator {
  const EmailValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  @override
  bool isValid(String value) => isEmail(value);
}

/// Ensures the value is a validly formatted phone number.
class PhoneValidator extends TextValidator {
  const PhoneValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  @override
  bool isValid(String value) => isPhoneNumber(value);
}

/// Ensures the value is a validly formatted URL.
class UrlValidator extends TextValidator {
  const UrlValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  @override
  bool isValid(String value) => isUrl(value);
}

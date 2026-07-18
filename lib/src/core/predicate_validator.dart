import 'validator.dart';

/// Builds a validator from a plain predicate — a one-off check without
/// declaring a new class.
///
/// ```dart
/// final finite = PredicateValidator<num>(
///   (v) => v.isFinite,
///   error: 'Must be a finite number',
/// );
/// finite(1.5);        // null
/// finite(double.nan); // 'Must be a finite number'
/// finite(null);       // null — empty input is skipped by default
/// ```
///
/// Like every non-text validator it treats only `null` as empty, so a
/// `PredicateValidator<String>` *does* run its predicate on blank strings.
/// Reach for the text validators (or check blankness in the predicate) when
/// blank input should be skipped.
class PredicateValidator<T extends Object> extends Validator<T> {
  /// Constructs a validator that reports [error] when [predicate] returns
  /// `false`.
  const PredicateValidator(
    this.predicate, {
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Decides whether a non-empty value is valid.
  ///
  /// `T` appears in a contravariant position here, which is formally unsound
  /// under covariant generics (upcasting to `PredicateValidator<Object>` and
  /// calling with the wrong type throws) — but that is the same soundness hole
  /// the whole `Validator<T>` hierarchy already has via `isValid(T)` /
  /// `call(T?)`, so the suppression keeps this consistent rather than adding a
  /// new one.
  // ignore: unsafe_variance
  final bool Function(T value) predicate;

  @override
  bool isValid(T value) => predicate(value);
}

import 'text_validator.dart';

/// Runs [validator] only when [condition] returns `true` for the current value.
///
/// This is the "validate sometimes" pattern: skip a rule entirely depending on
/// external state or the value itself. When the condition is `false` the field
/// is considered valid.
///
/// The reported error, when validation runs and fails, is the inner
/// [validator]'s error.
///
/// Example — only require a reason when a request is being rejected:
/// ```dart
/// final reason = ConditionalValidator(
///   condition: (_) => status == RequestStatus.rejected,
///   validator: const RequiredValidator(error: 'Please provide a reason'),
/// );
/// ```
class ConditionalValidator extends TextValidator {
  ConditionalValidator({
    required this.condition,
    required TextValidator validator,
  }) : validator = validator,
       // Adopt the inner validator's error so a caller reading [error] sees a
       // real message rather than an empty sentinel; the reported error still
       // comes from the inner validator via [call].
       super(error: validator.error, ignoreEmptyValues: false);

  /// Decides whether [validator] should run for the given value.
  final bool Function(String? value) condition;

  /// The validator applied when [condition] is `true`.
  final TextValidator validator;

  @override
  String? call(String? value) => condition(value) ? validator(value) : null;

  @override
  bool isValid(String value) => call(value) == null;
}

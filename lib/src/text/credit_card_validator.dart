import '../string/checkers.dart';
import 'text_validator.dart';

/// Ensures the value is a plausible credit card number.
///
/// Non-digit separators (spaces, dashes) are stripped before checking. The
/// number must both match a known card scheme pattern **and** pass the Luhn
/// checksum, so a well-formatted but mistyped number (e.g. a single wrong
/// digit) is rejected.
class CreditCardValidator extends TextValidator {
  const CreditCardValidator({
    required super.error,
    super.ignoreEmptyValues,
  });

  @override
  bool isValid(String value) {
    // Strip only the documented separators (spaces and dashes); any other
    // non-digit (e.g. a stray letter) is left in so the scheme check rejects
    // it rather than being silently deleted into a "valid" number.
    final sanitized = value.replaceAll(RegExp(r'[\s-]+'), '');

    return isCreditCard(sanitized) && isLuhn(sanitized);
  }
}

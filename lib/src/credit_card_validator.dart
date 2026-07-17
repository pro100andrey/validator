import 'string/checkers.dart';
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
    final sanitized = value.replaceAll(RegExp('[^0-9]+'), '');

    return isCreditCard(sanitized) && isLuhnValid(sanitized);
  }
}

import 'text_validator.dart';

class CreditCardValidator extends TextValidator {
  const CreditCardValidator({
    required super.error,
    super.emptyValueMode,
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

import 'patterns.dart';

/// Checks if the string consists only of whitespace characters (or is empty).
bool isWhitespace(String s) => Patterns.whitespace.hasMatch(s);

/// Checks if the string contains only alphabetic characters (letters).
bool isAlphabetic(String s) => Patterns.alpha.hasMatch(s);

/// Checks if the string contains only alphanumeric characters (letters and
/// numbers).
bool isAlphaNumeric(String s) => Patterns.alphaNumeric.hasMatch(s);

/// Checks if the string contains surrogate pairs used for encoding characters
/// outside the BMP in Unicode.
bool isSurrogatePairs(String s) => Patterns.surrogatePairs.hasMatch(s);

/// Checks if the string contains any non-ASCII Unicode characters.
bool isAnyNonAscii(String s) => Patterns.anyNonAscii.hasMatch(s);

/// Checks if the string contains only ASCII characters.
bool isOnlyAscii(String s) => Patterns.onlyAscii.hasMatch(s);

/// Checks if the string is a valid integer (positive, negative, or zero).
bool isInteger(String s) => Patterns.integer.hasMatch(s);

/// Checks if the string is a valid decimal number, with optional exponential
///  notation.
bool isDecimal(String s) => Patterns.decimal.hasMatch(s);

/// Checks if the string contains only numeric characters (positive or negative
/// integers).
bool isNumeric(String s) => Patterns.numeric.hasMatch(s);

/// Checks if the string is a valid hexadecimal number.
bool isHexadecimal(String s) => Patterns.hexadecimal.hasMatch(s);

/// Checks if the string is a valid hex color (e.g., `#FFF`, `#FFFFFF`).
bool isHexColor(String s) => Patterns.hexColor.hasMatch(s);

/// Checks if the string is a valid Base64-encoded string.
bool isBase64(String s) => Patterns.base64.hasMatch(s);

/// Checks if the string is a valid UUID version 3.
bool isUuidV3(String s) => Patterns.uuidV3.hasMatch(s);

/// Checks if the string is a valid UUID version 4.
bool isUuidV4(String s) => Patterns.uuidV4.hasMatch(s);

/// Checks if the string is a valid UUID version 5.
bool isUuidV5(String s) => Patterns.uuidV5.hasMatch(s);

/// Checks if the string is a valid UUID of any version.
bool isUuid(String s) => Patterns.uuid.hasMatch(s);

/// Checks if the string is a valid compact UUID (without hyphens).
bool isHexUuid(String s) => Patterns.hexUuid.hasMatch(s);

/// Checks if the string is a valid IPv4 address.
bool isIpv4(String s) => Patterns.ipv4.hasMatch(s);

/// Checks if the string is a valid IPv4 address with a subnet mask.
bool isIpv4WithMask(String s) => Patterns.ipv4WithMask.hasMatch(s);

/// Checks if the string is a valid IPv6 address.
bool isIpv6(String s) => Patterns.ipv6.hasMatch(s);

/// Checks if the string is a valid MAC address.
bool isMacAddress(String s) => Patterns.macAddress.hasMatch(s);

/// Checks if the string is a valid JSON Web Token (JWT).
bool isJwt(String s) => Patterns.jwt.hasMatch(s);

/// Checks if the string is a valid URL.
bool isUrl(String s) => Patterns.url.hasMatch(s);

/// Checks if the string is a valid email address.
bool isEmail(String s) => Patterns.email.hasMatch(s);

/// Checks if the string is a valid email address according to the RFC 5322
bool isEmailRFC5322(String s) => Patterns.emailRFC5322.hasMatch(s);

/// Checks if the string is a valid postal code.
bool isPostalCode(String s) => Patterns.postalCode.hasMatch(s);

/// Checks if the string is a valid phone number in local format.
bool isPhoneNumber(String s) => Patterns.phoneNumber.hasMatch(s);

/// Checks if the string is a valid credit card number.
bool isCreditCard(String s) => Patterns.creditCard.hasMatch(s);

/// Checks if a string of digits satisfies the Luhn checksum.
///
/// This is the checksum used by credit card numbers, IMEIs and similar
/// identifiers. The input must contain digits only; any other character makes
/// it invalid.
bool isLuhn(String s) {
  if (s.isEmpty) {
    return false;
  }

  var sum = 0;
  var alternate = false;
  for (var i = s.length - 1; i >= 0; i--) {
    final digit = s.codeUnitAt(i) ^ 0x30; // '0' is 0x30
    if (digit > 9) {
      return false;
    }

    var value = digit;
    if (alternate) {
      value *= 2;
      if (value > 9) {
        value -= 9;
      }
    }

    sum += value;
    alternate = !alternate;
  }

  return sum % 10 == 0;
}

/// Checks if the string is a valid date.
bool isDate(String s) => Patterns.date.hasMatch(s);

/// Checks if the string is a valid time (HH:mm:ss or HH:mm).
bool isTime(String s) => Patterns.time.hasMatch(s);

/// Checks if the string is a valid time in 12-hour format (HH:mm AM/PM).
bool isTime12Hour(String s) => Patterns.time12Hour.hasMatch(s);

/// Checks if the string is a valid ISO 8601 datetime.
bool isIso8601DateTime(String s) => Patterns.iso8601DateTime.hasMatch(s);

/// Checks if the string is a valid datetime (e.g., YYYY-MM-DD HH:mm:ss).
bool isDateTime(String s) => Patterns.dateTime.hasMatch(s);

/// Checks if the string contains a valid HTML tag.
bool isHtmlTag(String s) => Patterns.htmlTag.hasMatch(s);

/// Checks if the string is a valid URL slug.
bool isSlug(String s) => Patterns.slug.hasMatch(s);

/// Checks if the string is a valid hashtag (e.g., `#example`).
bool isHashtag(String s) => Patterns.hashtag.hasMatch(s);

/// Checks if the input string matches the given pattern.
bool hasMatch(String pattern, String input, {bool caseSensitive = true}) =>
    RegExp(pattern, caseSensitive: caseSensitive).hasMatch(input);

/// Checks if the string is a valid latitude.
bool isLatitude(String s) => Patterns.latitude.hasMatch(s);

/// Checks if the string is a valid longitude.
bool isLongitude(String s) => Patterns.longitude.hasMatch(s);

/// Checks if the string is a valid geo-coordinates.
bool isGeoCoordinates(String s) => Patterns.geoCoordinates.hasMatch(s);

/// Checks if the string is a valid IBAN (International Bank Account Number).
bool isIban(String s) => Patterns.iban.hasMatch(s);

/// Checks if the string is a valid SWIFT/BIC code.
bool isSwiftOrBic(String s) => Patterns.swiftOrBic.hasMatch(s);

/// Checks if the string is a valid VAT (Value Added Tax) number.
bool isVat(String s) => Patterns.vat.hasMatch(s);

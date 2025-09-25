import 'checkers.dart' as check;

extension StringCheck on String {
  /// Checks if the string consists only of whitespace characters (or is empty).
  bool get isWhitespace => check.isWhitespace(this);

  /// Checks if the string contains only alphabetic characters (letters).
  bool get isAlphabetic => check.isAlphabetic(this);

  /// Checks if the string contains only alphanumeric characters (letters and
  /// numbers).
  bool get isAlphaNumeric => check.isAlphaNumeric(this);

  /// Checks if the string contains surrogate pairs used for encoding characters
  /// outside the BMP in Unicode.
  bool get isSurrogatePairs => check.isSurrogatePairs(this);

  /// Checks if the string contains any non-ASCII Unicode characters.
  bool get isAnyNonAscii => check.isAnyNonAscii(this);

  /// Checks if the string contains only ASCII characters.
  bool get isOnlyAscii => check.isOnlyAscii(this);

  /// Checks if the string is a valid integer (positive, negative, or zero).
  bool get isInteger => check.isInteger(this);

  /// Checks if the string is a valid decimal number, with optional exponential
  ///  notation.
  bool get isDecimal => check.isDecimal(this);

  /// Checks if the string contains only numeric characters (positive or
  /// negative integers).
  bool get isNumeric => check.isNumeric(this);

  /// Checks if the string is a valid hexadecimal number.
  bool get isHexadecimal => check.isHexadecimal(this);

  /// Checks if the string is a valid hex color (e.g., `#FFF`, `#FFFFFF`).
  bool get isHexColor => check.isHexColor(this);

  /// Checks if the string is a valid Base64-encoded string.
  bool get isBase64 => check.isBase64(this);

  /// Checks if the string is a valid UUID version 3.
  bool get isUuidV3 => check.isUuidV3(this);

  /// Checks if the string is a valid UUID version 4.
  bool get isUuidV4 => check.isUuidV4(this);

  /// Checks if the string is a valid UUID version 5.
  bool get isUuidV5 => check.isUuidV5(this);

  /// Checks if the string is a valid UUID of any version.
  bool get isUuid => check.isUuid(this);

  /// Checks if the string is a valid compact UUID (without hyphens).
  bool get isHexUuid => check.isHexUuid(this);

  /// Checks if the string is a valid IPv4 address.
  bool get isIpv4 => check.isIpv4(this);

  /// Checks if the string is a valid IPv4 address with a subnet mask.
  bool get isIpv4WithMask => check.isIpv4WithMask(this);

  /// Checks if the string is a valid IPv6 address.
  bool get isIpv6 => check.isIpv6(this);

  /// Checks if the string is a valid MAC address.
  bool get isMacAddress => check.isMacAddress(this);

  /// Checks if the string is a valid JSON Web Token (JWT).
  bool get isJwt => check.isJwt(this);

  /// Checks if the string is a valid URL.
  bool get isUrl => check.isUrl(this);

  /// Checks if the string is a valid email address.
  bool get isEmail => check.isEmail(this);

  /// Checks if the string is a valid email address according to the RFC 5322
  bool get isEmailRFC5322 => check.isEmailRFC5322(this);

  /// Checks if the string is a valid postal code.
  bool get isPostalCode => check.isPostalCode(this);

  /// Checks if the string is a valid phone number in local format.
  bool get isPhoneNumber => check.isPhoneNumber(this);

  /// Checks if the string is a valid credit card number.
  bool get isCreditCard => check.isCreditCard(this);

  /// Checks if the string is a valid date.
  bool get isDate => check.isDate(this);

  /// Checks if the string is a valid time (HH:mm:ss or HH:mm).
  bool get isTime => check.isTime(this);

  /// Checks if the string is a valid time in 12-hour format (HH:mm AM/PM).
  bool get isTime12Hour => check.isTime12Hour(this);

  /// Checks if the string is a valid ISO 8601 datetime.
  bool get isIso8601DateTime => check.isIso8601DateTime(this);

  /// Checks if the string is a valid datetime (e.g., YYYY-MM-DD HH:mm:ss).
  bool get isDateTime => check.isDateTime(this);

  /// Checks if the string contains a valid HTML tag.
  bool get isHtmlTag => check.isHtmlTag(this);

  /// Checks if the string is a valid URL slug.
  bool get isSlug => check.isSlug(this);

  /// Checks if the string is a valid hashtag (e.g., `#example`).
  bool get isHashtag => check.isHashtag(this);
}



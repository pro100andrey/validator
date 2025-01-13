import 'patterns.dart';

/// Checks if the string consists only of whitespace characters (or is empty).
bool isWhitespace(String s) => Patterns.whitespace.pattern.hasMatch(s);

/// Checks if the string contains only alphabetic characters (letters).
bool isAlphabetic(String s) => Patterns.alpha.pattern.hasMatch(s);

/// Checks if the string contains only alphanumeric characters (letters and
/// numbers).
bool isAlphaNumeric(String s) => Patterns.alphaNumeric.pattern.hasMatch(s);

/// Checks if the string contains surrogate pairs used for encoding characters
/// outside the BMP in Unicode.
bool isSurrogatePairs(String s) => Patterns.surrogatePairs.pattern.hasMatch(s);

/// Checks if the string contains any non-ASCII Unicode characters.
bool isAnyNonAscii(String s) => Patterns.anyNonAscii.pattern.hasMatch(s);

/// Checks if the string contains only ASCII characters.
bool isOnlyAscii(String s) => Patterns.onlyAscii.pattern.hasMatch(s);

/// Checks if the string is a valid integer (positive, negative, or zero).
bool isInteger(String s) => Patterns.integer.pattern.hasMatch(s);

/// Checks if the string is a valid decimal number, with optional exponential
///  notation.
bool isDecimal(String s) => Patterns.decimal.pattern.hasMatch(s);

/// Checks if the string contains only numeric characters (positive or negative
/// integers).
bool isNumeric(String s) => Patterns.numeric.pattern.hasMatch(s);

/// Checks if the string is a valid hexadecimal number.
bool isHexadecimal(String s) => Patterns.hexadecimal.pattern.hasMatch(s);

/// Checks if the string is a valid hex color (e.g., `#FFF`, `#FFFFFF`).
bool isHexColor(String s) => Patterns.hexColor.pattern.hasMatch(s);

/// Checks if the string is a valid Base64-encoded string.
bool isBase64(String s) => Patterns.base64.pattern.hasMatch(s);

/// Checks if the string is a valid UUID version 3.
bool isUuidV3(String s) => Patterns.uuidV3.pattern.hasMatch(s);

/// Checks if the string is a valid UUID version 4.
bool isUuidV4(String s) => Patterns.uuidV4.pattern.hasMatch(s);

/// Checks if the string is a valid UUID version 5.
bool isUuidV5(String s) => Patterns.uuidV5.pattern.hasMatch(s);

/// Checks if the string is a valid UUID of any version.
bool isUuid(String s) => Patterns.uuid.pattern.hasMatch(s);

/// Checks if the string is a valid compact UUID (without hyphens).
bool isHexUuid(String s) => Patterns.hexUuid.pattern.hasMatch(s);

/// Checks if the string is a valid IPv4 address.
bool isIpv4(String s) => Patterns.ipv4.pattern.hasMatch(s);

/// Checks if the string is a valid IPv4 address with a subnet mask.
bool isIpv4WithMask(String s) => Patterns.ipv4WithMask.pattern.hasMatch(s);

/// Checks if the string is a valid IPv6 address.
bool isIpv6(String s) => Patterns.ipv6.pattern.hasMatch(s);

/// Checks if the string is a valid MAC address.
bool isMacAddress(String s) => Patterns.macAddress.pattern.hasMatch(s);

/// Checks if the string is a valid JSON Web Token (JWT).
bool isJwt(String s) => Patterns.jwt.pattern.hasMatch(s);

/// Checks if the string is a valid URL.
bool isUrl(String s) => Patterns.url.pattern.hasMatch(s);

/// Checks if the string is a valid email address.
bool isEmail(String s) => Patterns.email.pattern.hasMatch(s);

/// Checks if the string is a valid postal code.
bool isPostalCode(String s) => Patterns.postalCode.pattern.hasMatch(s);

/// Checks if the string is a valid phone number in local format.
bool isPhoneNumber(String s) => Patterns.phoneNumber.pattern.hasMatch(s);

/// Checks if the string is a valid international phone number.
bool isInternationalPhoneNumber(String s) =>
    Patterns.internationalPhoneNumber.pattern.hasMatch(s);

/// Checks if the string is a valid credit card number.
bool isCreditCard(String s) => Patterns.creditCard.pattern.hasMatch(s);

/// Checks if the string is a valid IBAN (International Bank Account Number).
bool isIban(String s) => Patterns.iban.pattern.hasMatch(s);

/// Checks if the string is a valid BIC (Bank Identifier Code).
bool isBic(String s) => Patterns.bic.pattern.hasMatch(s);

/// Checks if the string is a valid date.
bool isDate(String s) => Patterns.date.pattern.hasMatch(s);

/// Checks if the string is a valid time (HH:mm:ss or HH:mm).
bool isTime(String s) => Patterns.time.pattern.hasMatch(s);

/// Checks if the string is a valid time in 12-hour format (HH:mm AM/PM).
bool isTime12hour(String s) => Patterns.time12Hour.pattern.hasMatch(s);

/// Checks if the string is a valid ISO 8601 datetime.
bool isIso8601DateTime(String s) =>
    Patterns.iso8601DateTime.pattern.hasMatch(s);

/// Checks if the string is a valid datetime (e.g., YYYY-MM-DD HH:mm:ss).
bool isDateTime(String s) => Patterns.dateTime.pattern.hasMatch(s);

/// Checks if the string contains a valid HTML tag.
bool isHtmlTag(String s) => Patterns.htmlTag.pattern.hasMatch(s);

/// Checks if the string is a valid URL slug.
bool isSlug(String s) => Patterns.slug.pattern.hasMatch(s);

/// Checks if the string is a valid currency format.
bool isCurrency(String s) => Patterns.currency.pattern.hasMatch(s);

/// Checks if the string is a valid YouTube video ID.
bool isYoutubeVideoId(String s) => Patterns.youtubeVideoId.pattern.hasMatch(s);

/// Checks if the string is a valid YouTube video URL.
bool isYoutubeUrl(String s) => Patterns.youtubeUrl.pattern.hasMatch(s);

/// Checks if the string is a valid hashtag (e.g., `#example`).
bool isHashtag(String s) => Patterns.hashtag.pattern.hasMatch(s);

/// Checks if the string is a valid Unix-style file path.
bool isUnixFilePath(String s) => Patterns.unixFilePath.pattern.hasMatch(s);

/// Checks if the string is a valid Windows-style file path.
bool isWindowsFilePath(String s) =>
    Patterns.windowsFilePath.pattern.hasMatch(s);

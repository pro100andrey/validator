import 'patterns.dart';

bool isWhitespace(String s) => Patterns.whitespace.pattern.hasMatch(s);

bool isAlphabetic(String s) => Patterns.alpha.pattern.hasMatch(s);

bool isAlphaNumeric(String s) => Patterns.alphaNumeric.pattern.hasMatch(s);

bool isSurrogatePairs(String s) => Patterns.surrogatePairs.pattern.hasMatch(s);

bool isUnicode(String s) => Patterns.unicode.pattern.hasMatch(s);

bool isAscii(String s) => Patterns.ascii.pattern.hasMatch(s);

bool isInteger(String s) => Patterns.integer.pattern.hasMatch(s);

bool isDecimal(String s) => Patterns.decimal.pattern.hasMatch(s);

bool isNumeric(String s) => Patterns.numeric.pattern.hasMatch(s);

bool isHexadecimal(String s) => Patterns.hexadecimal.pattern.hasMatch(s);

bool isHexColor(String s) => Patterns.hexColor.pattern.hasMatch(s);

bool isRgbColor(String s) => Patterns.rgbColor.pattern.hasMatch(s);

bool isRgbaColor(String s) => Patterns.rgbaColor.pattern.hasMatch(s);

bool isHslColor(String s) => Patterns.hslColor.pattern.hasMatch(s);

bool isHslaColor(String s) => Patterns.hslaColor.pattern.hasMatch(s);

bool isHtmlColorName(String s) => Patterns.htmlColorName.pattern.hasMatch(s);

bool isBase64(String s) => Patterns.base64.pattern.hasMatch(s);

bool isUuidV3(String s) => Patterns.uuidV3.pattern.hasMatch(s);

bool isUuidV4(String s) => Patterns.uuidV4.pattern.hasMatch(s);

bool isUuidV5(String s) => Patterns.uuidV5.pattern.hasMatch(s);

bool isUuid(String s) => Patterns.uuid.pattern.hasMatch(s);

bool isHexUuid(String s) => Patterns.hexUuid.pattern.hasMatch(s);

bool isIpv4(String s) => Patterns.ipv4.pattern.hasMatch(s);

bool isIpv4WithMask(String s) => Patterns.ipv4WithMask.pattern.hasMatch(s);

bool isIpv6(String s) => Patterns.ipv6.pattern.hasMatch(s);

bool isMacAddress(String s) => Patterns.macAddress.pattern.hasMatch(s);

bool isJwt(String s) => Patterns.jwt.pattern.hasMatch(s);

bool isUrl(String s) => Patterns.url.pattern.hasMatch(s);

bool isEmail(String s) => Patterns.email.pattern.hasMatch(s);

bool isPostalCode(String s) => Patterns.postalCode.pattern.hasMatch(s);

bool isPhoneNumber(String s) => Patterns.phoneNumber.pattern.hasMatch(s);

bool isInternationalPhoneNumber(String s) =>
    Patterns.internationalPhoneNumber.pattern.hasMatch(s);

bool isCreditCard(String s) => Patterns.creditCard.pattern.hasMatch(s);

bool isIban(String s) => Patterns.iban.pattern.hasMatch(s);

bool isBic(String s) => Patterns.bic.pattern.hasMatch(s);

bool isDate(String s) => Patterns.date.pattern.hasMatch(s);

bool isTime(String s) => Patterns.time.pattern.hasMatch(s);

bool isTime12hour(String s) => Patterns.time12Hour.pattern.hasMatch(s);

bool isIso8601DateTime(String s) =>
    Patterns.iso8601DateTime.pattern.hasMatch(s);

bool isDateTime(String s) => Patterns.dateTime.pattern.hasMatch(s);

bool isHtmlTag(String s) => Patterns.htmlTag.pattern.hasMatch(s);

bool isSlug(String s) => Patterns.slug.pattern.hasMatch(s);

bool isCurrency(String s) => Patterns.currency.pattern.hasMatch(s);

bool isYoutubeVideoId(String s) => Patterns.youtubeVideoId.pattern.hasMatch(s);

bool isYoutubeUrl(String s) => Patterns.youtubeUrl.pattern.hasMatch(s);

bool isHashtag(String s) => Patterns.hashtag.pattern.hasMatch(s);

bool isUnixFilePath(String s) => Patterns.unixFilePath.pattern.hasMatch(s);

bool isWindowsFilePath(String s) =>
    Patterns.windowsFilePath.pattern.hasMatch(s);

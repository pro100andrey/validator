import 'check.dart' as check;

extension StringCheck on String {
  bool get isWhitespace => check.isWhitespace(this);

  bool get isAlphabetic => check.isAlphabetic(this);

  bool get isAlphaNumeric => check.isAlphaNumeric(this);

  bool get isSurrogatePairs => check.isSurrogatePairs(this);

  bool get isUnicode => check.isUnicode(this);

  bool get isAscii => check.isAscii(this);

  bool get isInteger => check.isInteger(this);

  bool get isDecimal => check.isDecimal(this);

  bool get isNumeric => check.isNumeric(this);

  bool get isHexadecimal => check.isHexadecimal(this);

  bool get isHexColor => check.isHexColor(this);

  bool get isRgbColor => check.isRgbColor(this);

  bool get isRgbaColor => check.isRgbaColor(this);

  bool get isHslColor => check.isHslColor(this);

  bool get isHslaColor => check.isHslaColor(this);

  bool get isHtmlColorName => check.isHtmlColorName(this);

  bool get isBase64 => check.isBase64(this);

  bool get isUuidV3 => check.isUuidV3(this);

  bool get isUuidV4 => check.isUuidV4(this);

  bool get isUuidV5 => check.isUuidV5(this);

  bool get isUuid => check.isUuid(this);

  bool get isHexUuid => check.isHexUuid(this);

  bool get isIpv4 => check.isIpv4(this);

  bool get isIpv4WithMask => check.isIpv4WithMask(this);

  bool get isIpv6 => check.isIpv6(this);

  bool get isMacAddress => check.isMacAddress(this);

  bool get isJwt => check.isJwt(this);

  bool get isUrl => check.isUrl(this);

  bool get isEmail => check.isEmail(this);

  bool get isPostalCode => check.isPostalCode(this);

  bool get isPhoneNumber => check.isPhoneNumber(this);

  bool get isInternationalPhoneNumber => check.isInternationalPhoneNumber(this);

  bool get isCreditCard => check.isCreditCard(this);

  bool get isIban => check.isIban(this);

  bool get isBic => check.isBic(this);

  bool get isDate => check.isDate(this);

  bool get isTime => check.isTime(this);

  bool get isTime12hour => check.isTime12hour(this);

  bool get isIso8601DateTime => check.isIso8601DateTime(this);

  bool get isDateTime => check.isDateTime(this);

  bool get isHtmlTag => check.isHtmlTag(this);

  bool get isSlug => check.isSlug(this);

  bool get isCurrency => check.isCurrency(this);

  bool get isYoutubeVideoId => check.isYoutubeVideoId(this);

  bool get isYoutubeUrl => check.isYoutubeUrl(this);

  bool get isHashtag => check.isHashtag(this);

  bool get isUnixFilePath => check.isUnixFilePath(this);

  bool get isWindowsFilePath => check.isWindowsFilePath(this);
}

// ignore_for_file: lines_longer_than_80_chars

enum Patterns {
  /// Matches a string consisting only of whitespace characters (or empty string).
  ///
  /// Examples:
  /// - `" "` (valid)
  /// - `"\t\n"` (valid)
  /// - `"abc"` (invalid)
  whitespace(r'^\s*$'),

  /// Matches alphabetic characters (letters only, case insensitive).
  ///
  /// Examples:
  /// - `"abc"` (valid)
  /// - `"ABC"` (valid)
  /// - `"abc123"` (invalid)
  alpha(r'^[a-zA-Z]+$'),

  /// Matches alphanumeric characters (letters and digits).
  ///
  /// Examples:
  /// - `"abc123"` (valid)
  /// - `"123"` (valid)
  /// - `"abc!"` (invalid)
  alphaNumeric(r'^[a-zA-Z0-9]+$'),

  /// Matches surrogate pairs used to encode characters outside the BMP in Unicode.
  ///
  /// Examples:
  /// - `"\uD83D\uDE00"` (valid, emoji 😊)
  /// - `"A"` (invalid)/// Surrogate pairs pattern.
  surrogatePairs(r'[\uD800-\uDBFF][\uDC00-\uDFFF]'),

  /// Matches any non-ASCII character.
  ///
  /// Examples:
  /// - `"Привіт"` (valid)
  /// - `"Hello"` (invalid)
  anyNonAscii(r'[^\x00-\x7F]'),

  /// Matches an ASCII-only string.
  ///
  /// Examples:
  /// - `"Hello"` (valid)
  /// - `"Привет"` (invalid)
  onlyAscii(r'^[\x00-\x7F]+$'),

  /// Matches an integer number (positive, negative, or zero).
  ///
  /// Examples:
  /// - `"123"` (valid)
  /// - `"-456"` (valid)
  /// - `"12.34"` (invalid)
  integer(r'^(?:-?(?:0|[1-9][0-9]*))$'),

  /// Matches a decimal number with optional exponential notation.
  ///
  /// Examples:
  /// - `"123.45"` (valid)
  /// - `"1.23e10"` (valid)
  /// - `"abc"` (invalid)
  decimal(r'^-?(?:[0-9]+)(?:\.[0-9]*)?(?:[eE][\+\-]?[0-9]+)?$'),

  /// Matches numeric characters only (positive or negative integers).
  ///
  /// Examples:
  /// - `"123"` (valid)
  /// - `"-123"` (valid)
  /// - `"12.34"` (invalid)
  numeric(r'^-?[0-9]+$'),

  /// Matches a hexadecimal string.
  ///
  /// Examples:
  /// - `"1f4"` (valid)
  /// - `"ABCDEF"` (valid)
  /// - `"GHI"` (invalid)
  hexadecimal(r'^[0-9a-fA-F]+$'),

  /// Matches a hex color string.
  ///
  /// Examples:
  /// - `"#FFF"` (valid)
  /// - `"#FFFFFF"` (valid)
  /// - `"FFF"` (valid)
  /// - `"123456"` (invalid)
  hexColor(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$'),

  /// Matches an RGB color string.
  ///
  /// Examples:
  /// - `"rgb(255, 0, 0)"` (valid)
  /// - `"rgb(0,0,0)"` (valid)
  /// - `"rgb(300, 0, 0)"` (invalid)
  rgbColor(r'^rgb\((\s*\d{1,3}\s*,){2}\s*\d{1,3}\s*\)$'),

  /// Matches an RGBA color string.
  ///
  /// Examples:
  /// - `"rgba(255, 0, 0, 0.5)"` (valid)
  /// - `"rgba(0, 0, 0, 1)"` (valid)
  /// - `"rgba(255,255,255,2)"` (invalid)
  rgbaColor(
    r'^rgba\((\s*\d{1,3}\s*,){3}\s*(0|0?\.\d+|1(\.0+)?)\s*\)$',
  ),

  /// Matches an HSL color string.
  ///
  /// Examples:
  /// - `"hsl(360, 100%, 50%)"` (valid)
  /// - `"hsl(0, 0%, 0%)"` (valid)
  /// - `"hsl(361, 50%, 50%)"` (invalid)
  hslColor(r'^hsl\(\s*(\d{1,3})\s*,\s*(\d{1,3})%\s*,\s*(\d{1,3})%\s*\)$'),

  /// Matches an HSLA color string.
  ///
  /// Examples:
  /// - `"hsla(360, 100%, 50%, 0.5)"` (valid)
  /// - `"hsla(0, 0%, 0%, 1)"` (valid)
  /// - `"hsla(360, 100%, 50%, 2)"` (invalid)
  hslaColor(
    r'^hsla\(\s*(\d{1,3})\s*,\s*(\d{1,3})%\s*,\s*(\d{1,3})%\s*,\s*(0|0?\.\d+|1(\.0+)?)\s*\)$',
  ),

  /// Matches a valid HTML color name.
  ///
  /// Examples:
  /// - `"red"` (valid)
  /// - `"blueviolet"` (valid)
  /// - `"notacolor"` (invalid)
  htmlColorName(
    r'^(?:aliceblue|antiquewhite|aqua|aquamarine|azure|beige|bisque|black|blanchedalmond|blue|blueviolet|brown|burlywood|cadetblue|chartreuse|chocolate|coral|cornflowerblue|cornsilk|crimson|cyan|darkblue|darkcyan|darkgoldenrod|darkgray|darkgreen|darkkhaki|darkmagenta|darkolivegreen|darkorange|darkorchid|darkred|darksalmon|darkseagreen|darkslateblue|darkslategray|darkturquoise|darkviolet|deeppink|deepskyblue|dimgray|dodgerblue|firebrick|floralwhite|forestgreen|fuchsia|gainsboro|ghostwhite|gold|goldenrod|gray|green|greenyellow|honeydew|hotpink|indianred|indigo|ivory|khaki|lavender|lavenderblush|lawngreen|lemonchiffon|lightblue|lightcoral|lightcyan|lightgoldenrodyellow|lightgray|lightgreen|lightpink|lightsalmon|lightseagreen|lightskyblue|lightslategray|lightsteelblue|lightyellow|lime|limegreen|linen|magenta|maroon|mediumaquamarine|mediumblue|mediumorchid|mediumpurple|mediumseagreen|mediumslateblue|mediumspringgreen|mediumturquoise|mediumvioletred|midnightblue|mintcream|mistyrose|moccasin|navajowhite|navy|oldlace|olive|olivedrab|orange|orangered|orchid|palegoldenrod|palegreen|paleturquoise|palevioletred|papayawhip|peachpuff|peru|pink|plum|powderblue|purple|rebeccapurple|red|rosybrown|royalblue|saddlebrown|salmon|sandybrown|seagreen|seashell|sienna|silver|skyblue|slateblue|slategray|snow|springgreen|steelblue|tan|teal|thistle|tomato|turquoise|violet|wheat|white|whitesmoke|yellow|yellowgreen)$',
  ),

  /// Matches a Base64 encoded string.
  ///
  /// Examples:
  /// - `"U29tZSB0ZXh0"` (valid)
  /// - `"123"` (invalid)
  base64(
    r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$',
  ),

  /// Matches a universally unique identifier (UUID) version 3 string.
  ///
  /// Examples:
  /// - `"123E4567-E89B-3D56-A456-426614174000"` (valid)
  uuidV3(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89ab][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
  ),

  /// Matches a universally unique identifier (UUID) version 4 string.
  ///
  /// Examples:
  /// - `"550E8400-E29B-41D4-A716-446655440000"` (valid)
  uuidV4(
    r'^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$',
  ),

  /// Matches a universally unique identifier (UUID) version 5 string.
  ///
  /// Examples:
  /// - `"F47AC10B-58CC-4372-A567-0E02B2C3D479"` (valid)
  uuidV5(
    r'^[0-9A-F]{8}-[0-9A-F]{4}-5[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$',
  ),

  /// Matches a universally unique identifier (UUID) string of any version.
  ///
  /// Examples:
  /// - `"123E4567-E89B-12D3-A456-426614174000"` (valid)
  uuid(r'^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$'),

  /// Matches a hexadecimal UUID.
  ///
  /// Examples:
  /// - `"123E4567E89B12D3A456426614174000"` (valid)
  /// - `"not-a-uuid"` (invalid)
  hexUuid(r'^[0-9a-fA-F]{32}$'),

  /// Matches an IPv4 address.
  ///
  /// Examples:
  /// - `"192.168.1.1"` (valid)
  /// - `"255.255.255.255"` (valid)
  /// - `"256.256.256.256"` (invalid)
  ipv4(
    r'^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$',
  ),

  /// Matches an IPv4 address with a subnet mask.
  ///
  /// Examples:
  /// - `"192.168.1.0/24"` (valid)
  /// - `"10.0.0.1/8"` (valid)
  /// - `"192.168.1.0"` (invalid, missing mask)
  ipv4WithMask(
    r'^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\/([1-9]|[1-2][0-9]|3[0-2])$',
  ),

  /// Matches a fully valid IPv6 address (including shorthand notation).
  ///
  /// Examples:
  /// - `"2001:0db8:85a3::8a2e:0370:7334"` (valid)
  /// - `"::1"` (valid)
  ipv6(
    r'^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}(([0-9]{1,3}\.){3,3}[0-9]{1,3})|([0-9a-fA-F]{1,4}:){1,4}:(([0-9]{1,3}\.){3,3}[0-9]{1,3}))$',
  ),

  /// Matches a MAC address.
  ///
  /// Examples:
  /// - `"00:1A:2B:3C:4D:5E"` (valid)
  /// - `"00-1A-2B-3C-4D-5E"` (valid)
  macAddress(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$'),

  /// Matches a JSON Web Token (JWT).
  ///
  /// Examples:
  /// - `"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"`
  ///   (valid)
  jwt(r'^[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+$'),

  /// Matches a URL.
  ///
  /// Examples:
  /// - `"https://example.com"` (valid)
  /// - `"http://www.example.com"` (valid)
  /// - `"example.com"` (invalid, missing protocol)
  url(r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})'),

  /// Matches an email address.
  ///
  /// Examples:
  /// - `"example@example.com"` (valid)
  /// - `"user.name+tag+sorting@example.com"` (valid)
  /// - `"plainaddress"` (invalid)
  email(
    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
  ),

  /// Matches a postal code (e.g., US ZIP Code).
  ///
  /// Examples:
  /// - `"12345"` (valid)
  /// - `"12345-6789"` (valid)
  /// - `"123"` (invalid)
  postalCode(r'^\d{5}(-\d{4})?$'),

  /// Matches a phone number in international or local format.
  ///
  /// Examples:
  /// - `"+1234567890"` (valid)
  /// - `"123-456-7890"` (valid)
  /// - `"abc-def-ghij"` (invalid)
  phoneNumber(r'^([+]?[\s0-9]+)?(\d{3}|[(]?[0-9]+[)])?([-]?[\s]?[0-9])+$'),

  /// Matches an international phone number.
  ///
  /// Examples:
  /// - `"+1234567890"` (valid)
  /// - `"+1 (234) 567-8900"` (valid)
  /// - `"123-456-7890"` (invalid, missing country code)
  internationalPhoneNumber(r'^\+?[1-9]\d{1,14}$'),

  /// Regex pattern to validate credit card numbers.
  ///
  /// - `Visa` - numbers start with a 4. New cards have 16 digits. Old cards
  /// have 13.
  /// - `MasterCard` numbers either start with the numbers 51 through 55 or with
  /// the numbers 2221 through 2720. All have 16 digits.
  /// - `American Express` numbers start with 34 or 37 and have 15 digits.
  /// - `Diners Club` - is a 14-digit number beginning with 300–305, 36, 38, or 39.
  /// - `Discover` numbers start with 6011, 644–649, or 65, and have 16 digits.
  /// - `JCB` numbers start with 3528–3589 and have 16 digits.
  ///
  /// Examples:
  /// - `"4111 1111 1111 1111"` (Visa, valid)
  /// - `"5500 0000 0000 0004"` (MasterCard, valid)
  /// - `"1234 5678 9012 3456"` (invalid)
  creditCard('^('
      '?:4[0-9]{12}(?:[0-9]{3})?' // Visa
      '|(?:5[1-5][0-9]{2}' // MasterCard
      '|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}'
      '|3[47][0-9]{13}' // American Express
      '|3(?:0[0-5]|[68][0-9])[0-9]{11}' // Diners Club
      '|6(?:011|5[0-9]{2})[0-9]{12}' // Discover
      '|(?:2131|1800|35[0-9]{3})[0-9]{11}' // JCB
      r')$'),

  /// Matches an International Bank Account Number (IBAN).
  ///
  /// Examples:
  /// - `"GB29NWBK60161331926819"` (valid)
  /// - `"123456"` (invalid)
  iban(r'^[A-Z]{2}\d{2}[A-Z0-9]{1,30}$'),

  /// Matches a valid BIC (Bank Identifier Code).
  ///
  /// Examples:
  /// - `"DEUTDEFFXXX"` (valid)
  /// - `"NEDSZAJJ"` (valid)
  /// - `"INVALIDBIC"` (invalid)
  bic(r'^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$'),

  /// Matches a date in the format YYYY-MM-DD.
  ///
  /// Examples:
  /// - `"2023-01-12"` (valid)
  /// - `"2023-02-30"` (invalid)
  /// - `"12-01-2023"` (invalid)
  date(r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$'),

  /// Matches a time in the format HH:mm:ss or HH:mm.
  ///
  /// Examples:
  /// - `"23:59:59"` (valid)
  /// - `"00:00"` (valid)
  /// - `"25:00:00"` (invalid)
  time(r'^([01]\d|2[0-3]):([0-5]\d)(:[0-5]\d)?$'),

  time12Hour(r'^(0?[1-9]|1[0-2]):[0-5][0-9] (AM|PM)$'),

  /// Matches an ISO 8601 DateTime string.
  ///
  /// Examples:
  /// - `"2023-01-12T15:30:00Z"` (valid)
  /// - `"2023-01-12"` (invalid, missing time part)
  iso8601DateTime(
    r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?Z$',
  ),

  /// Matches a date and time in the format YYYY-MM-DD HH:mm:ss.
  ///
  /// Examples:
  /// - `"2023-01-12 15:30:45"` (valid)
  /// - `"2023-02-30 12:00:00"` (invalid)
  /// - `"2023-01-12T15:30:45"` (invalid)
  dateTime(
    r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]) (0[0-9]|1[0-9]|2[0-3]):[0-5]\d:[0-5]\d$',
  ),

  /// Matches an HTML tag.
  ///
  /// Examples:
  /// - `"<div>"` (valid)
  /// - `"<a href='#'>"` (valid)
  /// - `"div"` (invalid)
  htmlTag(r'<\/?[a-zA-Z][a-zA-Z0-9]*[^<>]*>'),

  /// Matches a slug (e.g., for URLs).
  ///
  /// Examples:
  /// - `"my-page-title"` (valid)
  /// - `"MyPageTitle"` (invalid, uppercase letters not allowed)
  slug(r'^[a-z0-9]+(?:-[a-z0-9]+)*$'),

  // Matches a monetary value (e.g., $1234.56).
  ///
  /// Examples:
  /// - `"$1234.56"` (valid)
  /// - `"1234.56"` (valid)
  /// - `"1234.5"` (invalid)
  currency(
    r'^(?:(?:[^\d\s.,-] ?)?-?(\d{1,3}([,\.]\d{3})*|(\d+))([,\.]\d{1,2})?)$',
  ),

  /// Matches a YouTube video ID.
  ///
  /// Examples:
  /// - `"dQw4w9WgXcQ"` (valid)
  /// - `"12345"` (invalid, too short)
  youtubeVideoId(r'^[a-zA-Z0-9_-]{11}$'),

  /// Matches a YouTube video URL.
  ///
  /// Examples:
  /// - `"https://www.youtube.com/watch?v=dQw4w9WgXcQ"` (valid)
  /// - `"https://youtu.be/dQw4w9WgXcQ"` (valid)
  /// - `"https://example.com/watch?v=dQw4w9WgXcQ"` (invalid)
  youtubeUrl(
    r'^(https?:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)[a-zA-Z0-9_-]{11}$',
  ),

  /// Matches a hashtag.
  ///
  /// Examples:
  /// - `"#example"` (valid)
  /// - `"example"` (invalid, missing '#')
  hashtag(r'^#[a-zA-Z0-9_]+$'),

  /// Matches a Unix-style file path.
  ///
  /// Examples:
  /// - `"/usr/local/bin"` (valid)
  /// - `"~/Documents/file.txt"` (valid)
  /// - `"C:\Windows\System32"` (invalid)
  unixFilePath(r'^(/[^/\0]+)+/?$'),

  /// Matches a Windows-style file path.
  ///
  /// Examples:
  /// - `"C:\\Users\\John\\Documents"` (valid)
  /// - `"C:/Windows/System32"` (valid)
  /// - `"invalidPath/"` (invalid)
  windowsFilePath(r'^[a-zA-Z]:\\(?:[^\\/:*?"<>|\r\n]+\\)*[^\\/:*?"<>|\r\n]*$'),
  ;

  const Patterns(this.regex);

  final String regex;

  /// Returns a regular expression for the given pattern.
  RegExp get pattern => _table[this]!;
}

/// Table of common patterns.

final _table = <Patterns, RegExp>{
  Patterns.whitespace: RegExp(Patterns.whitespace.regex),
  Patterns.alpha: RegExp(Patterns.alpha.regex),
  Patterns.alphaNumeric: RegExp(Patterns.alphaNumeric.regex),
  Patterns.surrogatePairs: RegExp(Patterns.surrogatePairs.regex),
  Patterns.anyNonAscii: RegExp(Patterns.anyNonAscii.regex),
  Patterns.onlyAscii: RegExp(Patterns.onlyAscii.regex),
  Patterns.integer: RegExp(Patterns.integer.regex),
  Patterns.decimal: RegExp(Patterns.decimal.regex),
  Patterns.numeric: RegExp(Patterns.numeric.regex),
  Patterns.hexadecimal: RegExp(Patterns.hexadecimal.regex),
  Patterns.hexColor: RegExp(Patterns.hexColor.regex),
  Patterns.rgbColor: RegExp(Patterns.rgbColor.regex),
  Patterns.rgbaColor: RegExp(Patterns.rgbaColor.regex),
  Patterns.hslColor: RegExp(Patterns.hslColor.regex),
  Patterns.hslaColor: RegExp(Patterns.hslaColor.regex),
  Patterns.htmlColorName: RegExp(Patterns.htmlColorName.regex),
  Patterns.base64: RegExp(Patterns.base64.regex),
  Patterns.uuidV3: RegExp(Patterns.uuidV3.regex),
  Patterns.uuidV4: RegExp(Patterns.uuidV4.regex),
  Patterns.uuidV5: RegExp(Patterns.uuidV5.regex),
  Patterns.uuid: RegExp(Patterns.uuid.regex),
  Patterns.hexUuid: RegExp(Patterns.hexUuid.regex),
  Patterns.ipv4: RegExp(Patterns.ipv4.regex),
  Patterns.ipv4WithMask: RegExp(Patterns.ipv4WithMask.regex),
  Patterns.ipv6: RegExp(Patterns.ipv6.regex),
  Patterns.macAddress: RegExp(Patterns.macAddress.regex),
  Patterns.jwt: RegExp(Patterns.jwt.regex),
  Patterns.url: RegExp(Patterns.url.regex),
  Patterns.email: RegExp(Patterns.email.regex),
  Patterns.postalCode: RegExp(Patterns.postalCode.regex),
  Patterns.phoneNumber: RegExp(Patterns.phoneNumber.regex),
  Patterns.internationalPhoneNumber: RegExp(Patterns.internationalPhoneNumber.regex),
  Patterns.creditCard: RegExp(Patterns.creditCard.regex),
  Patterns.iban: RegExp(Patterns.iban.regex),
  Patterns.bic: RegExp(Patterns.bic.regex),
  Patterns.date: RegExp(Patterns.date.regex),
  Patterns.time: RegExp(Patterns.time.regex),
  Patterns.time12Hour: RegExp(Patterns.time12Hour.regex),
  Patterns.iso8601DateTime: RegExp(Patterns.iso8601DateTime.regex),
  Patterns.dateTime: RegExp(Patterns.dateTime.regex),
  Patterns.htmlTag: RegExp(Patterns.htmlTag.regex),
  Patterns.slug: RegExp(Patterns.slug.regex),
  Patterns.currency: RegExp(Patterns.currency.regex),
  Patterns.youtubeVideoId: RegExp(Patterns.youtubeVideoId.regex),
  Patterns.youtubeUrl: RegExp(Patterns.youtubeUrl.regex),
  Patterns.hashtag: RegExp(Patterns.hashtag.regex),
  Patterns.unixFilePath: RegExp(Patterns.unixFilePath.regex),
  Patterns.windowsFilePath: RegExp(Patterns.windowsFilePath.regex),
};

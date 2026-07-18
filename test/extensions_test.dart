import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

/// Every `StringCheck` getter is a hand-written delegate to a top-level `isX`
/// checker. This guards the wiring: for a value that is valid for the format,
/// the getter and its checker must agree (and both be `true`). A getter pointed
/// at the wrong checker would return `false` here and fail the test.
void main() {
  final cases =
      <
        ({
          String name,
          bool Function(String) getter,
          bool Function(String) checker,
          String sample,
        })
      >[
        (
          name: 'isWhitespace',
          getter: (s) => s.isWhitespace,
          checker: isWhitespace,
          sample: '   ',
        ),
        (
          name: 'isAlphabetic',
          getter: (s) => s.isAlphabetic,
          checker: isAlphabetic,
          sample: 'abc',
        ),
        (
          name: 'isAlphaNumeric',
          getter: (s) => s.isAlphaNumeric,
          checker: isAlphaNumeric,
          sample: 'abc123',
        ),
        (
          name: 'isSurrogatePairs',
          getter: (s) => s.isSurrogatePairs,
          checker: isSurrogatePairs,
          sample: '😀',
        ),
        (
          name: 'isAnyNonAscii',
          getter: (s) => s.isAnyNonAscii,
          checker: isAnyNonAscii,
          sample: 'é',
        ),
        (
          name: 'isOnlyAscii',
          getter: (s) => s.isOnlyAscii,
          checker: isOnlyAscii,
          sample: 'abc',
        ),
        (
          name: 'isInteger',
          getter: (s) => s.isInteger,
          checker: isInteger,
          sample: '123',
        ),
        (
          name: 'isDecimal',
          getter: (s) => s.isDecimal,
          checker: isDecimal,
          sample: '1.5',
        ),
        (
          name: 'isNumeric',
          getter: (s) => s.isNumeric,
          checker: isNumeric,
          sample: '123',
        ),
        (
          name: 'isHexadecimal',
          getter: (s) => s.isHexadecimal,
          checker: isHexadecimal,
          sample: '1a2f',
        ),
        (
          name: 'isHexColor',
          getter: (s) => s.isHexColor,
          checker: isHexColor,
          sample: '#fff',
        ),
        (
          name: 'isBase64',
          getter: (s) => s.isBase64,
          checker: isBase64,
          sample: 'U29tZQ==',
        ),
        (
          name: 'isUuidV3',
          getter: (s) => s.isUuidV3,
          checker: isUuidV3,
          sample: '123e4567-e89b-32d3-a456-426614174000',
        ),
        (
          name: 'isUuidV4',
          getter: (s) => s.isUuidV4,
          checker: isUuidV4,
          sample: '550e8400-e29b-41d4-a716-446655440000',
        ),
        (
          name: 'isUuidV5',
          getter: (s) => s.isUuidV5,
          checker: isUuidV5,
          sample: '123e4567-e89b-52d3-a456-426614174000',
        ),
        (
          name: 'isUuid',
          getter: (s) => s.isUuid,
          checker: isUuid,
          sample: '123e4567-e89b-12d3-a456-426614174000',
        ),
        (
          name: 'isHexUuid',
          getter: (s) => s.isHexUuid,
          checker: isHexUuid,
          sample: '123e4567e89b12d3a456426614174000',
        ),
        (
          name: 'isIpv4',
          getter: (s) => s.isIpv4,
          checker: isIpv4,
          sample: '192.168.1.1',
        ),
        (
          name: 'isIpv4WithMask',
          getter: (s) => s.isIpv4WithMask,
          checker: isIpv4WithMask,
          sample: '192.168.1.0/24',
        ),
        (
          name: 'isIpv6',
          getter: (s) => s.isIpv6,
          checker: isIpv6,
          sample: '::1',
        ),
        (
          name: 'isMacAddress',
          getter: (s) => s.isMacAddress,
          checker: isMacAddress,
          sample: '00:1a:2b:3c:4d:5e',
        ),
        (
          name: 'isJwt',
          getter: (s) => s.isJwt,
          checker: isJwt,
          sample: 'a.b.c',
        ),
        (
          name: 'isUrl',
          getter: (s) => s.isUrl,
          checker: isUrl,
          sample: 'https://example.com',
        ),
        (
          name: 'isEmail',
          getter: (s) => s.isEmail,
          checker: isEmail,
          sample: 'user@mail.com',
        ),
        (
          name: 'isEmailRFC5322',
          getter: (s) => s.isEmailRFC5322,
          checker: isEmailRFC5322,
          sample: 'user@mail.com',
        ),
        (
          name: 'isPostalCode',
          getter: (s) => s.isPostalCode,
          checker: isPostalCode,
          sample: '12345',
        ),
        (
          name: 'isPhoneNumber',
          getter: (s) => s.isPhoneNumber,
          checker: isPhoneNumber,
          sample: '+1234567890',
        ),
        (
          name: 'isCreditCard',
          getter: (s) => s.isCreditCard,
          checker: isCreditCard,
          sample: '4111111111111111',
        ),
        (
          name: 'isDate',
          getter: (s) => s.isDate,
          checker: isDate,
          sample: '2023-01-12',
        ),
        (
          name: 'isTime',
          getter: (s) => s.isTime,
          checker: isTime,
          sample: '23:59:59',
        ),
        (
          name: 'isTime12Hour',
          getter: (s) => s.isTime12Hour,
          checker: isTime12Hour,
          sample: '12:00 AM',
        ),
        (
          name: 'isIso8601DateTime',
          getter: (s) => s.isIso8601DateTime,
          checker: isIso8601DateTime,
          sample: '2023-01-12T15:30:00Z',
        ),
        (
          name: 'isDateTime',
          getter: (s) => s.isDateTime,
          checker: isDateTime,
          sample: '2023-01-12 15:30:45',
        ),
        (
          name: 'isHtmlTag',
          getter: (s) => s.isHtmlTag,
          checker: isHtmlTag,
          sample: '<div>',
        ),
        (
          name: 'isSlug',
          getter: (s) => s.isSlug,
          checker: isSlug,
          sample: 'my-page',
        ),
        (
          name: 'isHashtag',
          getter: (s) => s.isHashtag,
          checker: isHashtag,
          sample: '#tag',
        ),
        (
          name: 'isLatitude',
          getter: (s) => s.isLatitude,
          checker: isLatitude,
          sample: '45.0',
        ),
        (
          name: 'isLongitude',
          getter: (s) => s.isLongitude,
          checker: isLongitude,
          sample: '120.0',
        ),
        (
          name: 'isGeoCoordinates',
          getter: (s) => s.isGeoCoordinates,
          checker: isGeoCoordinates,
          sample: '45.0, -120.0',
        ),
        (
          name: 'isIban',
          getter: (s) => s.isIban,
          checker: isIban,
          sample: 'DE89370400440532013000',
        ),
        (
          name: 'isSwiftOrBic',
          getter: (s) => s.isSwiftOrBic,
          checker: isSwiftOrBic,
          sample: 'DEUTDEFF',
        ),
        (
          name: 'isVat',
          getter: (s) => s.isVat,
          checker: isVat,
          sample: 'DE123456789',
        ),
        (
          name: 'isLuhn',
          getter: (s) => s.isLuhn,
          checker: isLuhn,
          sample: '79927398713',
        ),
      ];

  group('StringCheck getters delegate to their checker', () {
    for (final c in cases) {
      test('${c.name} matches its checker', () {
        expect(
          c.checker(c.sample),
          isTrue,
          reason: '${c.name} sample "${c.sample}" should be valid',
        );
        expect(
          c.getter(c.sample),
          c.checker(c.sample),
          reason: '.${c.name} must delegate to ${c.name}(...)',
        );
      });
    }

    test('covers every checker (43 formats)', () {
      expect(cases, hasLength(43));
    });
  });
}

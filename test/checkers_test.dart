import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('checkers', () {
    test('isEmail', () {
      expect(isEmail('user@mail.com'), isTrue);
      expect(isEmail('nope'), isFalse);
    });

    test('isUrl', () {
      expect(isUrl('https://example.com'), isTrue);
      expect(isUrl('example'), isFalse);
    });

    test('isUuid', () {
      expect(isUuid('123E4567-E89B-12D3-A456-426614174000'), isTrue);
      expect(isUuid('not-a-uuid'), isFalse);
    });

    test('isIpv4', () {
      expect(isIpv4('192.168.1.1'), isTrue);
      expect(isIpv4('256.0.0.1'), isFalse);
    });

    test('isHexColor', () {
      expect(isHexColor('#FFF'), isTrue);
      expect(isHexColor('#FFFFFF'), isTrue);
      expect(isHexColor('#GGG'), isFalse);
      // The leading '#' is required, so hex-lettered words are not colors.
      expect(isHexColor('123456'), isFalse);
      expect(isHexColor('decade'), isFalse);
      expect(isHexColor('#12345'), isFalse);
    });

    test('isDecimal', () {
      expect(isDecimal('123.45'), isTrue);
      expect(isDecimal('1.23e10'), isTrue);
      expect(isDecimal('-42'), isTrue);
      // A dot must be followed by at least one digit.
      expect(isDecimal('123.'), isFalse);
      expect(isDecimal('abc'), isFalse);
    });

    test('isIso8601DateTime', () {
      expect(isIso8601DateTime('2023-01-12T15:30:00Z'), isTrue);
      // Offset is optional: a local timestamp (Dart's own local ISO output).
      expect(isIso8601DateTime('2023-01-12T15:30:00.000'), isTrue);
      expect(
        isIso8601DateTime(DateTime(2023, 1, 12, 15, 30).toIso8601String()),
        isTrue,
      );
      // Extended, basic and hour-only offsets all parse.
      expect(isIso8601DateTime('2023-01-12T15:30:00+02:00'), isTrue);
      expect(isIso8601DateTime('2023-01-12T15:30:00+0200'), isTrue);
      expect(isIso8601DateTime('2023-01-12T15:30:00-05'), isTrue);
      // Missing the time part is still invalid.
      expect(isIso8601DateTime('2023-01-12'), isFalse);
    });

    test('isSlug', () {
      expect(isSlug('my-page-title'), isTrue);
      expect(isSlug('My Page'), isFalse);
    });
  });

  group('StringCheck extension', () {
    test('mirrors the checker functions', () {
      expect('user@mail.com'.isEmail, isTrue);
      expect('#example'.isHashtag, isTrue);
      expect('DE89370400440532013000'.isIban, isTrue);
      expect('45.0, -120.0'.isGeoCoordinates, isTrue);
    });
  });

  group('case-insensitive formats accept lowercase', () {
    test('UUID', () {
      expect(isUuid('f47ac10b-58cc-4372-a567-0e02b2c3d479'), isTrue);
      expect(isUuidV4('550e8400-e29b-41d4-a716-446655440000'), isTrue);
      expect(isHexUuid('f47ac10b58cc4372a5670e02b2c3d479'), isTrue);
    });

    test('hex color (both cases)', () {
      expect(isHexColor('#abcdef'), isTrue);
      expect(isHexColor('#ABCDEF'), isTrue);
    });

    test('MAC address (both cases)', () {
      expect(isMacAddress('00:1a:2b:3c:4d:5e'), isTrue);
      expect(isMacAddress('00:1A:2B:3C:4D:5E'), isTrue);
    });

    test('email (uppercase)', () => expect(isEmail('USER@MAIL.COM'), isTrue));
  });

  group('isEmailRFC5322', () {
    test('accepts valid addresses (incl. unicode domain)', () {
      expect(isEmailRFC5322('example@example.com'), isTrue);
      expect(isEmailRFC5322('user.name+tag+sorting@example.com'), isTrue);
      expect(isEmailRFC5322('first.last@sub.domain.example.org'), isTrue);
      expect(isEmailRFC5322('x@münchen.de'), isTrue);
    });

    test('rejects invalid addresses', () {
      expect(isEmailRFC5322('plainaddress'), isFalse);
      expect(isEmailRFC5322('a@b'), isFalse);
      expect(isEmailRFC5322('a@.com'), isFalse);
      expect(isEmailRFC5322('a@b..com'), isFalse);
    });

    test('is linear on an adversarial input (ReDoS regression)', () {
      // Before the domain-label fix, "a@" + "a." * n backtracked
      // exponentially: ~22s at 52 chars. It must now stay well under a second
      // even for a very long input.
      final attack = 'a@${'a.' * 2000}';
      final sw = Stopwatch()..start();
      final result = isEmailRFC5322(attack);
      sw.stop();
      expect(result, isFalse);
      expect(
        sw.elapsed,
        lessThan(const Duration(seconds: 1)),
        reason: 'emailRFC5322 must not backtrack catastrophically',
      );
    });
  });
}

// ignore_for_file: lines_longer_than_80_chars

import 'package:pro_validator/src/check.dart';
import 'package:test/test.dart';

void main() {
  group('Check', () {
    test('isWhitespace', () {
      final valid = [
        '',
        ' ',
        '\t',
        '\n',
        '\r',
        ' \t\n\r',
      ];

      for (final whitespace in valid) {
        expect(isWhitespace(whitespace), isTrue, reason: whitespace);
      }

      final invalid = [
        'a',
        ' a',
        'a ',
      ];

      for (final whitespace in invalid) {
        expect(isWhitespace(whitespace), isFalse, reason: whitespace);
      }
    });

    test('isAlphabetic', () {
      final valid = [
        'a',
        'A',
        'z',
        'Z',
        'aA',
      ];

      for (final alphabetic in valid) {
        expect(isAlphabetic(alphabetic), isTrue, reason: alphabetic);
      }

      final invalid = [
        '',
        'a ',
        ' a',
        '1',
        '!',
      ];

      for (final alphabetic in invalid) {
        expect(isAlphabetic(alphabetic), isFalse, reason: alphabetic);
      }
    });

    test('isAlphaNumeric', () {
      final valid = [
        'a',
        'A',
        'z',
        'Z',
        '0',
        '9',
        'aA',
        'a1',
        '1a',
        '123',
        'abc',
      ];

      for (final alphaNumeric in valid) {
        expect(isAlphaNumeric(alphaNumeric), isTrue, reason: alphaNumeric);
      }

      final invalid = [
        '',
        'a ',
        ' a',
        '!',
        ' ',
      ];

      for (final alphaNumeric in invalid) {
        expect(isAlphaNumeric(alphaNumeric), isFalse, reason: alphaNumeric);
      }
    });

    test('isSurrogatePairs', () {
      final valid = [
        '😀',
        'a😀',
        '😊😉😍',
        '\uD83D\uDC00',
      ];

      for (final surrogatePairs in valid) {
        expect(
          isSurrogatePairs(surrogatePairs),
          isTrue,
          reason: surrogatePairs,
        );
      }

      final invalid = [
        'a',
        'abc',
        '123',
        '!@#',
        '',
        '\n',
        '\uD83D',
        '\uDC00',
      ];

      for (final surrogatePairs in invalid) {
        expect(
          isSurrogatePairs(surrogatePairs),
          isFalse,
          reason: surrogatePairs,
        );
      }
    });

    test('anyNonAscii', () {
      final valid = [
        '😀',
        'a😀',
        '😊😉😍',
        '😀a',
        'a😀b',
        '😀😊😉😍',
        'a😀😊😉😍b',
      ];

      for (final nonAscii in valid) {
        expect(isAnyNonAscii(nonAscii), isTrue, reason: nonAscii);
      }

      final invalid = [
        'a',
        'abc',
        '123',
        '!@#',
        '',
        '\n',
      ];

      for (final nonAscii in invalid) {
        expect(isAnyNonAscii(nonAscii), isFalse, reason: nonAscii);
      }
    });

    test('isOnlyAscii', () {
      final valid = [
        'a',
        'abc',
        '123',
        '!@#',
        ' ',
        '\n',
      ];

      for (final ascii in valid) {
        expect(isOnlyAscii(ascii), isTrue, reason: ascii);
      }

      final invalid = [
        '😀',
        'a😀',
        '😊😉😍',
        '😀a',
        'a😀b',
        '😀😊😉😍',
        'a😀😊😉😍b',
      ];

      for (final ascii in invalid) {
        expect(isOnlyAscii(ascii), isFalse, reason: ascii);
      }
    });

    test('isInteger', () {
      final valid = [
        '0',
        '1',
        '123',
        '-1',
        '-123',
      ];

      for (final integer in valid) {
        expect(isInteger(integer), isTrue, reason: integer);
      }

      final invalid = [
        '',
        'a',
        '1.0',
        '1.1',
        '1.1e10',
      ];

      for (final integer in invalid) {
        expect(isInteger(integer), isFalse, reason: integer);
      }
    });

    test('isDecimal', () {
      final valid = [
        '0',
        '1',
        '123',
        '-1',
        '-123',
        '1.0',
        '1.1',
        '1.1e10',
      ];

      for (final decimal in valid) {
        expect(isDecimal(decimal), isTrue, reason: decimal);
      }

      final invalid = [
        '',
        'a',
        '1.1e',
        '1.1e+',
      ];

      for (final decimal in invalid) {
        expect(isDecimal(decimal), isFalse, reason: decimal);
      }
    });

    test('isNumeric', () {
      final valid = [
        '0',
        '000',
        '1',
        '123',
        '-1',
        '-123',
      ];

      for (final numeric in valid) {
        expect(isNumeric(numeric), isTrue, reason: numeric);
      }

      final invalid = [
        '1.1e10',
        '1.0',
        '',
        'a',
        '1.1e',
        '1.1e+',
      ];

      for (final numeric in invalid) {
        expect(isNumeric(numeric), isFalse, reason: numeric);
      }
    });

    test('isHexadecimal', () {
      final valid = [
        '0',
        '1',
        '123',
        'a',
        'A',
        'f',
        'F',
        'abcdef',
        'ABCDEF',
      ];

      for (final hexadecimal in valid) {
        expect(isHexadecimal(hexadecimal), isTrue, reason: hexadecimal);
      }

      final invalid = [
        'g',
        'G',
        '123g',
        '123G',
        '',
        '1.0',
        '1.1e10',
      ];

      for (final hexadecimal in invalid) {
        expect(isHexadecimal(hexadecimal), isFalse, reason: hexadecimal);
      }
    });

    test('isHexColor', () {
      final valid = [
        '#FFF',
        'FFF',
        '#FFFFFF',
        'FFFFFF',
      ];

      for (final hexColor in valid) {
        expect(isHexColor(hexColor), isTrue, reason: hexColor);
      }

      final invalid = [
        '#GGG',
        '#FFFFF',
        '',
        '1234567',
      ];

      for (final hexColor in invalid) {
        expect(isHexColor(hexColor), isFalse, reason: hexColor);
      }
    });

    test('isBase64', () {
      final valid = [
        'aA==',
        'ThisIsBase64Because/ItIsMod4',
        'ThisIsAlso/Base64+EvenWithPadding+==',
        'YouGetTheIdea/==',
      ];

      for (final base64 in valid) {
        expect(isBase64(base64), isTrue, reason: base64);
      }

      final invalid = [
        '',
        'aA',
        'aA=',
        'YW55IGNhcm5hbCBwbGVhc3VyZQ',
        'YW55IGNhcm5hbCBwbGVhc3VyZ=',
        'YW55IGNhcm5hbCBwbGVhc3VyZQ===',
        'aA==aA==aA==',
        '123!@#',
        '  YW55IGNhcm5hbCBwbGVhc3VyZQ==',
      ];

      for (final base64 in invalid) {
        expect(isBase64(base64), isFalse, reason: base64);
      }
    });

    test('isUuidV3', () {
      final valid = [
        '6fa459ea-ee8a-3ca4-894e-db77e160355e',
        'f47ac10b-58cc-3372-a567-0e02b2c3d479',
        '6FA459EA-EE8A-3CA4-894E-DB77E160355E',
        'F47AC10B-58CC-3372-A567-0E02B2C3D479',
      ];

      for (final uuid in valid) {
        expect(isUuidV3(uuid), isTrue, reason: uuid);
      }

      final invalid = [
        '',
        '6fa459ea-ee8a-3ca4-894e-db77e160355',
        '6fa459ea-ee8a-3ca4-894e-db77e160355e1',
        '6fa459ea-ee8a-3ca4-894e-db77e160355g',
        '6fa459ea-ee8a-3ca4-894e-db77e160355e ',
        '6fa459ea-ee8a-3ca4-894e-db77e160355e-extra',
      ];

      for (final uuid in invalid) {
        expect(isUuidV3(uuid), isFalse, reason: uuid);
      }
    });

    test('isUuidV4', () {
      final valid = [
        '550e8400-e29b-41d4-a716-446655440000',
        '36e7e210-8cf7-41d3-b3fc-38c3e2d88b3e',
        '123e4567-e89b-41d4-a716-426655440000',
        'f47ac10b-58cc-41d4-a567-0e02b2c3d479',
        '550E8400-E29B-41D4-A716-446655440000',
      ];

      for (final uuid in valid) {
        expect(isUuidV4(uuid), isTrue, reason: uuid);
      }

      final invalid = [
        '',
        '123e4567-e89b-12d3-a456-426614174000',
        '550e8400-e29b-41d4-a716-44665544000',
        '550e8400-e29b-41d4-a716-4466554400000',
        '550e8400-e29b-41d4-a716-44665544000g',
        '550e8400e29b41d4a716446655440000',
        '550e8400-e29b-41d4-a716-446655440000-extra',
        '550E8400-E29B-51D4-A716-446655440000',
      ];

      for (final uuid in invalid) {
        expect(isUuidV4(uuid), isFalse, reason: uuid);
      }
    });

    test('isUuidV5', () {
      final valid = [
        'f47ac10b-58cc-5372-a567-0e02b2c3d479',
        'F47AC10B-58CC-5372-A567-0E02B2C3D479',
        '123e4567-e89b-52d3-a456-426614174000',
        '550e8400-e29b-51d4-a716-446655440000',
        '36e7e210-8cf7-51d3-b3fc-38c3e2d88b3e',
      ];

      for (final uuid in valid) {
        expect(isUuidV5(uuid), isTrue, reason: uuid);
      }

      final invalid = [
        '',
        '123e4567-e89b-12d3-a456-426614174000',
        '550e8400-e29b-41d4-a716-446655440000',
        '550e8400-e29b-51d4-a716-44665544000',
        '550e8400-e29b-51d4-a716-4466554400000',
        '550e8400-e29b-51d4-a716-44665544000g',
        '550e8400e29b51d4a716446655440000',
        '550e8400-e29b-51d4-a716-446655440000-extra',
        '550E8400-E29B-41D4-A716-446655440000',
      ];

      for (final uuid in invalid) {
        expect(isUuidV5(uuid), isFalse, reason: uuid);
      }
    });

    test('isUuid', () {
      final valid = [
        '550e8400-e29b-41d4-a716-446655440000',
        '550E8400-E29B-41D4-A716-446655440000',
        '123e4567-e89b-12d3-a456-426614174000',
        'f47ac10b-58cc-5372-a567-0e02b2c3d479',
        '36e7e210-8cf7-51d3-b3fc-38c3e2d88b3e',
      ];

      for (final uuid in valid) {
        expect(isUuid(uuid), isTrue, reason: uuid);
      }

      final invalid = [
        '',
        '550e8400-e29b-41d4-a716-44665544000',
        '550e8400-e29b-41d4-a716-4466554400000',
        '550e8400-e29b-41d4-a716-44665544000g',
        '550e8400e29b41d4a716446655440000',
        '550e8400-e29b-41d4-a716-446655440000-extra',
      ];

      for (final uuid in invalid) {
        expect(isUuid(uuid), isFalse, reason: uuid);
      }
    });

    test('isHexUuid', () {
      final valid = [
        '550e8400e29b41d4a716446655440000',
        '550E8400E29B41D4A716446655440000',
        '123e4567e89b12d3a456426614174000',
        'f47ac10b58cc5372a5670e02b2c3d479',
        '36e7e2108cf751d3b3fc38c3e2d88b3e',
      ];

      for (final hexUuid in valid) {
        expect(isHexUuid(hexUuid), isTrue, reason: hexUuid);
      }

      final invalid = [
        '',
        '550e8400e29b41d4a71644665544000',
        '550e8400e29b41d4a7164466554400000',
        '550e8400e29b41d4a71644665544000g',
        '550e8400-e29b-41d4-a716-446655440000',
        '550e8400e29b41d4a716446655440000-extra',
      ];

      for (final hexUuid in invalid) {
        expect(isHexUuid(hexUuid), isFalse, reason: hexUuid);
      }
    });

    test('isIpv4', () {
      final valid = [
        '192.168.1.1',
        '255.255.255.255',
        '0.0.0.0',
        '127.0.0.1',
        '10.0.0.1',
      ];

      for (final ipv4 in valid) {
        expect(isIpv4(ipv4), isTrue, reason: ipv4);
      }

      final invalid = [
        '',
        '256.256.256.256',
        '192.168.1',
        '192.168.1.256',
        '192.168.1.1.1',
        '192.168.1.-1',
        '192.168.1.abc',
        '192.168.1.01',
        '192.168.1.1 ',
        ' 192.168.1.1',
      ];

      for (final ipv4 in invalid) {
        expect(isIpv4(ipv4), isFalse, reason: ipv4);
      }
    });

    test('isIpv4WithMask', () {
      final valid = [
        '192.168.1.0/24',
        '10.0.0.1/8',
        '172.16.0.0/16',
        '255.255.255.255/32',
        '0.0.0.0/0',
      ];

      for (final ipv4WithMask in valid) {
        expect(isIpv4WithMask(ipv4WithMask), isTrue, reason: ipv4WithMask);
      }

      final invalid = [
        '',
        '192.168.1.0',
        '192.168.1.0/33',
        '256.256.256.256/24',
        '192.168.1.0/-1',
        '192.168.1.0/abc',
        '192.168.1.0/24 ',
        ' 192.168.1.0/24',
        '192.168.1.0/024',
        '192.168.1.0/3a',
      ];

      for (final ipv4WithMask in invalid) {
        expect(isIpv4WithMask(ipv4WithMask), isFalse, reason: ipv4WithMask);
      }
    });

    test('isIpv6', () {
      final valid = [
        '::1',
        '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
        '2001:db8:85a3::8a2e:370:7334',
        '::ffff:192.168.1.1',
        'fe80::1%lo0',
        '2001:0db8:0000:0000:0000:ff00:0042:8329',
        '2001:db8::ff00:42:8329',
      ];

      for (final ipv6 in valid) {
        expect(isIpv6(ipv6), isTrue, reason: ipv6);
      }

      final invalid = [
        '',
        '1200::AB00:1234::2552:7777:1313',
        '1200::AB00:1234:GHIJ:2552:7777:1313',
        '::ffff:300.168.1.1',
        '2001:db8:85a3:0:0:8a2e:370:7334:1234',
        '2001:db8:85a3',
        '2001:db8:85a3:0000:0000:8a2e:0370:7334:extra',
        '2001:db8:85a3::8a2e:370:7334 extra',
      ];

      for (final ipv6 in invalid) {
        expect(isIpv6(ipv6), isFalse, reason: ipv6);
      }
    });

    test('isMacAddress', () {
      final valid = [
        '00:1A:2B:3C:4D:5E',
        '00-1A-2B-3C-4D-5E',
        '00:1a:2b:3c:4d:5e',
        '00-1a-2b-3c-4d-5e',
      ];

      for (final macAddress in valid) {
        expect(isMacAddress(macAddress), isTrue, reason: macAddress);
      }

      final invalid = [
        '',
        '001A2B3C4D5E',
        '00:1A:2B:3C:4D',
        '00:1A:2B:3C:4D:5E:6F',
        '00:1A:2B:3C:4D:G1',
        '00:1A:2B:3C:4D:5E ',
        ' 00:1A:2B:3C:4D:5E',
      ];

      for (final macAddress in invalid) {
        expect(isMacAddress(macAddress), isFalse, reason: macAddress);
      }
    });

    test('isJwt', () {
      final valid = [
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5cA',
      ];

      for (final jwt in valid) {
        expect(isJwt(jwt), isTrue, reason: jwt);
      }

      final invalid = [
        '',
        'header.payload',
        'header.payload.signature.',
        'header.payload.signature.extra',
        'header.payload.signature!',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.',
      ];

      for (final jwt in invalid) {
        expect(isJwt(jwt), isFalse, reason: jwt);
      }
    });

    test('isUrl', () {
      final valid = [
        'https://example.com',
        'http://example.com',
        'https://www.example.com',
        'http://www.example.com',
        'www.example.com',
        'https://example.com/path/to/resource',
        'https://example.com?query=string',
        'https://example.com#fragment',
        'https://subdomain.example.com',
      ];

      for (final url in valid) {
        expect(isUrl(url), isTrue, reason: url);
      }

      final invalid = [
        '',
        'example',
        'example.',
        'example.c',
        '://example.com',
        'https//example.com',
        'http:/example.com',
        'www.example',
        'https://example',
        'https://.example.com',
      ];

      for (final url in invalid) {
        expect(isUrl(url), isFalse, reason: url);
      }
    });
  });
}

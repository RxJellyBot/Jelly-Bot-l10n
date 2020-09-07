import 'package:l10n/l10n.dart';
import 'package:test/test.dart';

void main() {
  group('default format provider tests', () {
    test('format number', () {
      expect(FormatProvider.number.format(78.426, '##.##'), equals('78.43'));
    });
    test('format date', () {
      expect(
          FormatProvider.date
              .format(DateTime(2020, 9, 11, 15, 24, 36), 'HH:mm:ss'),
          equals('15:24:36'));
    });
  });

  group('format tests', () {
    test('format combinations', () {
      expect(
          format(r'${key:HH:mm:ss}, $key, ${num:##.##}, $num2', {
            'key': DateTime(2020, 9, 11, 15, 24, 36),
            'num': 78.426,
            'num2': 1.5
          }),
          equals('15:24:36, September 11, 2020 3:24:36 PM, 78.43, 1.5'));
    });
  });
}

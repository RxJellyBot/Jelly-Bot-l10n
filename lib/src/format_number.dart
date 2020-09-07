import 'package:intl/intl.dart';
import 'package:l10n/l10n.dart';
import 'package:l10n/src/locale.dart';

String formatNumber(num value, String format, LocaleProvider locale) =>
    NumberFormat(format, locale?.INTL).format(value);

class NumberFormatProvier implements FormatProvider<num> {
  final String _fallbackFormat;
  const NumberFormatProvier([this._fallbackFormat]);

  @override
  String format(num value, [String format, LocaleProvider locale]) =>
      formatNumber(value, format ?? _fallbackFormat, locale);
}

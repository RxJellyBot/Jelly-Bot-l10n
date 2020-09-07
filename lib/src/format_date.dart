import '../l10n.dart';
import 'package:intl/intl.dart' as intl;

String formatDateTime(DateTime value, [String format, LocaleProvider locale]) =>
    intl.DateFormat(format, locale?.INTL).format(value);

class DateFormatProvier implements FormatProvider<DateTime> {
  final String _fallbackFormat;
  const DateFormatProvier([this._fallbackFormat]);
  @override
  String format(DateTime value, [String format, LocaleProvider locale]) =>
      formatDateTime(value, format ?? _fallbackFormat);
}

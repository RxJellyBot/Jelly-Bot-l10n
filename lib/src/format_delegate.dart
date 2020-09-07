import 'format_provider.dart';
import 'locale.dart';

typedef FormatFunction<TValue> = String Function(
    TValue value, String format, LocaleProvider locale);

class FormatDelegate<TValue> implements FormatProvider<TValue> {
  final FormatFunction<TValue> _delegate;

  const FormatDelegate(this._delegate);

  @override
  String format(TValue value, [String format, LocaleProvider locale]) {
    return _delegate.call(value, format, locale);
  }
}

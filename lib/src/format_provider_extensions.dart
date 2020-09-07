import 'format_provider.dart';
import 'locale.dart';

class CastFormatProvider<TFrom, TValue> implements FormatProvider<TFrom> {
  final FormatProvider<TValue> _provider;

  const CastFormatProvider(this._provider);

  @override
  String format(TFrom value, [String format, LocaleProvider locale]) =>
      value is TValue ? _provider.format(value, format, locale) : null;
}

class MergeFormatProvider<TValue> implements FormatProvider<TValue> {
  final List<FormatProvider<TValue>> _providerList;

  const MergeFormatProvider(this._providerList);

  @override
  String format(TValue value, [String format, LocaleProvider locale]) {
    for (var provider in _providerList) {
      var result = provider.format(value, format, locale);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}

class BranchWithComparableFormatProvider<TValue extends Comparable<TValue>>
    implements FormatProvider<TValue> {
  final TValue _compareTo;
  final FormatProvider<TValue> _lessProvider;
  final FormatProvider<TValue> _largeEqualProvider;
  const BranchWithComparableFormatProvider(
      this._compareTo, this._lessProvider, this._largeEqualProvider);

  @override
  String format(TValue value, [String format, LocaleProvider locale]) {
    return (value.compareTo(_compareTo) < 0)
        ? _lessProvider.format(value, format, locale)
        : _largeEqualProvider.format(value, format, locale);
  }
}

extension FormatProviderExtensions<TValue> on FormatProvider<TValue> {
  FormatProvider<T> cast<T>() {
    return CastFormatProvider<T, TValue>(this);
  }
}

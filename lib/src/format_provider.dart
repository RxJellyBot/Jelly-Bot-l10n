import 'package:l10n/src/locale.dart';

import 'format_delegate.dart';
import 'format_number.dart';
import 'format_date.dart';
import 'format_provider_extensions.dart';

abstract class FormatProvider<TValue> {
  const FormatProvider();

  String format(TValue value, [String format, LocaleProvider locale]);

  /// Provides format to string from function
  static FormatProvider<T> create<T>(FormatFunction<T> formatFunction) {
    return FormatDelegate(formatFunction);
  }

  /// Provides format to string with multiple providers
  ///
  /// Merges all provider and call with them sequentially until has result instance
  static FormatProvider<T> merge<T>(List<FormatProvider> providerList) {
    return MergeFormatProvider<T>(providerList);
  }

  /// Provides format to string use branches provider
  ///
  /// If value is less then compareToValue, lessProvider will be used or largeEqualProvider instead.
  static FormatProvider<T> branchWithCompare<T extends Comparable<T>>(
      T compareToValue,
      FormatProvider<T> lessProvider,
      FormatProvider<T> largeEqualProvider) {
    return BranchWithComparableFormatProvider<T>(
        compareToValue, lessProvider, largeEqualProvider);
  }

  /// Provides format to string of number
  ///
  /// Format with package:intl implementation
  static const FormatProvider<num> number = NumberFormatProvier();

  /// Provides format to string of DateTime
  ///
  /// Format with package:simple_moment implementation
  static const FormatProvider<DateTime> date = DateFormatProvier();

  /// Global format provider
  ///
  /// prior to default provider
  static FormatProvider global;

  /// Default format provider
  ///
  /// library's default provider
  static const FormatProvider $default = MergeFormatProvider(
      <FormatProvider>[CastFormatProvider(number), CastFormatProvider(date)]);
}

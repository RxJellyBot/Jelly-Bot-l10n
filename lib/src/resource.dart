import 'dart:async';

import 'locale.dart';
import 'platform.dart';

abstract class ResourceProvider implements PlatformProvider {
  final LocaleProvider locale;

  /// Constructor
  ///
  /// @optional:
  ///   [localeProvider]: choose locale for resources handling, if not specified will select as default [LocaleProvider.global]
  ResourceProvider([LocaleProvider localeProvider])
      : locale = localeProvider ?? LocaleProvider.global;

  /// Initialize this [ResourceProvider], prepare everything [ResourceProvider] needs, list as below:
  ///   - String Table (res@string.json)
  FutureOr<void> initialize();

  /// Read all contents as [String] with [key]
  Future<String> readAsString(String key);

  /// Get [String] with [key] in resource which read from json with key 'res@string.json' and formatted as below:
  /// {
  ///   "[key]": "[result]"
  ///   ...
  /// }
  String getString(int key);
}

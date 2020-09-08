import 'package:l10n/src/locale.dart';

import 'format_provider.dart';

/// group 1 is variable key
/// group 2 is format string
final _patternFormat =
    //group             | 1 |     | 2 |
    RegExp(r'(?<!\\)\%\{(\w+)(?:\|(.*?))?\}', multiLine: true);

/// Groups pre define
const int _kGroupName = 1;
const int _kGroupFormat = 2;

/// Format to string
///
/// Replace arguments into [fromString] with patterns as below:
///
///   %{name} will replaces with element 'name' in [args]
///   %{name:fmt} will replaces with element 'name' in [args] and format use 'fmt' pattern
///
/// @optionals:
///   [provider]: top level of [FormatProvider] for this call, as is [FormatProvider.global] and [FormatProvider.$default]
String format(String fromString, Map<String, dynamic> args,
    {FormatProvider provider, LocaleProvider locale}) {
  return fromString.replaceAllMapped(_patternFormat, (match) {
    var key = match.group(_kGroupName);
    var f = match.group(_kGroupFormat);
    var val = args[key];
    if (val == null) {
      return '{$key}';
    }
    return provider?.format(val, f) ??
        FormatProvider.global?.format(val, f) ??
        FormatProvider.$default.format(val, f) ??
        val.toString();
  });
}

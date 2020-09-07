import 'package:l10n/src/locale.dart';

import 'format_provider.dart';

/// group 1 or 3 will present as variable key
/// group 2 is format string
final _patternFormat =
    //group         | 1 |    | 2 |       | 3 |
    RegExp(r'(?:\$\{(\w+)(?::(.*?))?\}|\$(\w+))', multiLine: true);

/// Groups pre define
const int _kGroupName_1 = 1;
const int _kGroupName_2 = 3;
const int _kGroupFormat = 2;

/// Format to string
///
/// Replace arguments into [fromString] with patterns as below:
///
///   ${key} will replaces with element 'key' in [args]
///   $key will replaces with element 'key' in [args]
///   ${key:fmt} will replaces with element 'key' in [args] and format use 'fmt' pattern
///
/// @optionals:
///   [provider]: top level of [FormatProvider] for this call, as is [FormatProvider.global] and [FormatProvider.$default]
String format(String fromString, Map<String, dynamic> args,
    {FormatProvider provider, LocaleProvider locale}) {
  return fromString.replaceAllMapped(_patternFormat, (match) {
    var key = match.group(_kGroupName_1);
    String f;
    if (key != null) {
      f = match.group(_kGroupFormat);
    } else {
      key = match.group(_kGroupName_2);
    }
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

import 'resource.dart';
import 'format_provider.dart';
import 'format.dart' as fmt;

extension ResourceProviderExtension on ResourceProvider {
  /// Same as [format], but retrive source [String] use [getString(key)]
  String format(int key, Map<String, dynamic> args, {FormatProvider provider}) {
    var value = getString(key);
    if (value != null) {
      return fmt.format(value, args, provider: provider, locale: locale);
    }
    return null;
  }
}

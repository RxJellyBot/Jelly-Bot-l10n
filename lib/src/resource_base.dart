import 'dart:async';
import 'dart:convert';

import 'package:l10n/src/locale.dart';
import 'resource.dart';

const String _kStringTable = 'res@string.json';

Map<int, String> _readStringTable(String jsonString) {
  var json = jsonDecode(jsonString);
  if (json is! Map<String, dynamic>) {
    throw JsonUnsupportedObjectError(json);
  }
  var map = json as Map<String, dynamic>;
  return map.map(
      (key, value) => MapEntry<int, String>(int.parse(key), value.toString()));
}

abstract class BaseResourceProvider implements ResourceProvider {
  @override
  final LocaleProvider locale;
  Map<int, String> _res$StringTable;

  BaseResourceProvider([LocaleProvider localeProvider])
      : locale = localeProvider ?? LocaleProvider.global;

  @override
  Future<void> initialize() async {
    var jsonStr = await readAsString(_kStringTable);
    _res$StringTable = await compute(_readStringTable, jsonStr);
  }

  @override
  String getString(int key) => _res$StringTable[key];
}

class LocaleCodes {
  static const String en_US = 'en-us';
  static const String zh_TW = 'zh-tw';
}

class LocaleProvider {
  final String CODE;
  final String INTL;

  const LocaleProvider._(this.CODE, {this.INTL});

  factory LocaleProvider.desired(String code) {
    switch (code) {
      case 'zh-tw':
        return zh_TW;
      case 'en-us':
      default:
        return en_US;
    }
  }

  static final LocaleProvider en_US =
      LocaleProvider._(LocaleCodes.en_US, INTL: 'en_US');
  static final LocaleProvider zh_TW =
      LocaleProvider._(LocaleCodes.zh_TW, INTL: 'zh_TW');

  static LocaleProvider global = en_US;
}

enum SupportedLocale { en, ar }

extension SupportedLocalExtension on SupportedLocale {
  String get code => toString().split('.').last;
  String get name {
    String name;
    switch (this) {
      case SupportedLocale.en:
        name = 'English';
        break;
      case SupportedLocale.ar:
        name = 'Arabic';
        break;
    }
    return name;
  }
}

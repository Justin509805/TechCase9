import 'package:flutter_localization/flutter_localization.dart'; // Imports

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("de", LocaleData.DE),
  MapLocale("nl", LocaleData.NL),
  MapLocale("zh", LocaleData.ZH),
  MapLocale("ar", LocaleData.AR),
];

mixin LocaleData {
  static const String title = 'title';
  static const String body = 'body';
  static const String charging = 'charging';
  static const String discharging = 'discharging';

  static const Map<String, dynamic> EN = { // Translations
    title: 'Battery App',
    body: 'Battery Percentage: %a',
    charging: 'Charging Minutes: %a',
    discharging: 'Discharging Minutes: %a',
  };

  static const Map<String, dynamic> DE = {
    title: 'Akku-App',
    body: 'Akku Prozent: %a',
    charging: 'Ladungsprozentsatz: %a',
    discharging: 'Entladungsprozentsatz: %a',
  };

  static const Map<String, dynamic> NL = {
    title: 'Batterij App',
    body: 'Batterij Percentage: %a',
    charging: 'Oplaad Percentage: %a',
    discharging: 'Ontlaad Percentage: %a',
  };

  static const Map<String, dynamic> ZH = {
    title: '电池应用',
    body: '电池百分比: %a',
    charging: '充电百分比: %a',
    discharging: '放电百分比: %a',
  };

  static const Map<String, dynamic> AR = {
    title: 'تطبيق البطارية',
    body: 'نسبة البطارية: %a',
    charging: 'نسبة الشحن: %a',
    discharging: 'نسبة التفريغ: %a',
  };
}


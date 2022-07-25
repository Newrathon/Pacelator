import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

//reference: https://github.com/flutter/website/blob/archived-master/examples/internationalization/minimal/lib/main.dart
//fk flutter l10n;so complex
class MinimalLocalizations {
  MinimalLocalizations(this.locale);

  final Locale locale;

  static MinimalLocalizations of(BuildContext context) {
    return Localizations.of<MinimalLocalizations>(
        context, MinimalLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'title': 'Pace Calculator',
      'raceType:customized': 'Customized Distance',
      'raceType:50m': '50m',
      'raceType:100m': '100m',
      'raceType:800m': '800m',
      'raceType:1000m': '1000m',
      'raceType:5k': '5km',
      'raceType:10k': '10km',
      'raceType:21k': 'Half Marathon',
      'raceType:30k': '30km',
      'raceType:42k': 'Marathon',
      'raceType:50k': '50km',
      'raceType:100k': '100km',
      'raceType:1mi': '1mi',
      'raceType:13mi': 'Half Marathon',
      'raceType:26mi': 'Marathon',
      'distanceUnit:metric': 'Metric',
      'distanceUnit:statute': 'Statute',
      'distanceUnit:unknown': 'Unknown',
    },
    'zh': {
      'title': '配速计算器',
      'raceType:customized': '自定义距离',
      'raceType:50m': '50 米',
      'raceType:100m': '100 米',
      'raceType:800m': '800 米',
      'raceType:1000m': '1000 米',
      'raceType:5k': '5 千米',
      'raceType:10k': '10 千米',
      'raceType:21k': '半程马拉松',
      'raceType:30k': '30 千米',
      'raceType:42k': '马拉松',
      'raceType:50k': '50 千米',
      'raceType:100k': '100 千米',
      'raceType:1mi': '1 英里',
      'raceType:13mi': '半程马拉松',
      'raceType:26mi': '马拉松',
      'distanceUnit:metric': '公制',
      'distanceUnit:statute': '英制',
      'distanceUnit:unknown': '未知',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

  String get title {
    return _localizedValues[locale.languageCode]!['title']!;
  }

  String getL10nByKey(String key) {
    return _localizedValues[locale.languageCode]![key]!;
  }
}

class MinimalLocalizationsDelegate
    extends LocalizationsDelegate<MinimalLocalizations> {
  const MinimalLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      MinimalLocalizations.languages().contains(locale.languageCode);

  @override
  Future<MinimalLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of MinimalLocalizations.
    return SynchronousFuture<MinimalLocalizations>(
        MinimalLocalizations(locale));
  }

  @override
  bool shouldReload(MinimalLocalizationsDelegate old) => false;
}

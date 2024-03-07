import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:winch/models/subtitle.dart';

class WinchLocalization {
  WinchLocalization(this.locale);

  final Locale locale;
  static WinchLocalization of(BuildContext context) {
    return Localizations.of<WinchLocalization>(context, WinchLocalization);
  }

  Subtitle _subtitle;
  Subtitle get subtitle => _subtitle;

  Future<void> load() async {
    String jsonStringValues =
    await rootBundle.loadString('assets/subtitles/${locale.languageCode}_subtitle.json');
    _subtitle = Subtitle.fromJson(json.decode(jsonStringValues));
  }



  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<WinchLocalization> delegate =
  _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<WinchLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<WinchLocalization> load(Locale locale) async {
    WinchLocalization localization = new WinchLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<WinchLocalization> old) => false;
}
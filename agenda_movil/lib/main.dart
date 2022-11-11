import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/MyApp.dart';
import 'package:agenda_movil/src/Persistence/Percistence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  // https://www.science.co.il/language/Codes.php  Codigos de lenguajes
  LocalizationDelegate delegate = await LocalizationDelegate.create(
    // basePath: 'i18n',
    fallbackLocale: 'es',//lenguaje con el que el aplicativo inicia
    supportedLocales: ['en', 'es', 'fr', 'pt', 'de', 'zh', 'ja', 'ru']
  );
  Percistence _percistence = Percistence();
  await _percistence.initPrefs();
  runApp(Provider(child: LocalizedApp(delegate, MyApp())));
}

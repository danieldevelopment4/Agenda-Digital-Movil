import 'package:agenda_movil/src/pages/SplashScreen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static of(BuildContext context) {}
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;
  ThemeMode _themeMode = ThemeMode.system;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Center(
          //child: HomePage(),
          child: SplashScreenWidget(),
        ));
  }
}

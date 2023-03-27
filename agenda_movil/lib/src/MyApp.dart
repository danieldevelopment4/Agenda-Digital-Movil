// ignore_for_file: file_names

import 'package:agenda_movil/src/Persistence/Percistence.dart';
import 'package:agenda_movil/src/Routes/Routes.dart';
import 'package:agenda_movil/src/pages/HomePage.dart';
import 'package:agenda_movil/src/pages/LogginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Percistence _percistence = Percistence();

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    List<LocalizationsDelegate<dynamic>> delegates = List.empty(growable: true);
    delegates.addAll(GlobalMaterialLocalizations.delegates);
    delegates.add(GlobalWidgetsLocalizations.delegate);
    delegates.add(localizationDelegate);
    
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        title: "Agenda Digital",
        debugShowCheckedModeBanner: false,
        initialRoute: (_percistence.student!="")?HomePage.homeRoute:LogginPage.route,
        // initialRoute: Loggin.route,
        routes: getRoutes(),
        onGenerateRoute: (settings){
          return MaterialPageRoute(builder: error404());
        },
      ),
    );
  }
}
// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Persistence/Percistence.dart';
import 'package:agenda_movil/src/Routes/Routes.dart';
import 'package:agenda_movil/src/pages/HomePage.dart';
import 'package:agenda_movil/src/pages/LogginPage.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Percistence _percistence = Percistence();

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: "Agenda Digital",
        debugShowCheckedModeBanner: false,
        initialRoute: (_percistence.student!="")?HomePage.HomeRoute:LogginPage.route,
        // initialRoute: Loggin.route,
        routes: getRoutes(),
        onGenerateRoute: (settings){
          return MaterialPageRoute(builder: error404());
        },
      ),
    );
  }
}
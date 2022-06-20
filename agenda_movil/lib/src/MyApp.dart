import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Routes/Routes.dart';
import 'package:agenda_movil/src/pages/Login.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: "Agenda Digital",
        debugShowCheckedModeBanner: false,
        initialRoute: Login.route,
        routes: getRoutes(),
        onGenerateRoute: (settings){
          return MaterialPageRoute(builder: error404());
        },
      ),
    );
  }
}
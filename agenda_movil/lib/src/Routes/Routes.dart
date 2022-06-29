import 'package:agenda_movil/src/pages/Rate.dart';
import 'package:flutter/material.dart';

import 'package:agenda_movil/src/pages/Error404.dart';
import 'package:agenda_movil/src/pages/Home.dart';
import 'package:agenda_movil/src/pages/Login.dart';
import 'package:agenda_movil/src/pages/Register.dart';
import 'package:agenda_movil/src/pages/Subject.dart';
import 'package:agenda_movil/src/pages/createActivity.dart';
import 'package:agenda_movil/src/pages/createSubject.dart';
import 'package:agenda_movil/src/pages/createTeacher.dart';

Map<String, WidgetBuilder>getRoutes(){
  return <String,WidgetBuilder>{
    Home.HomeRoute : (BuildContext context) => Home(0),
    Home.CalendarRoute : (BuildContext context) => Home(1),
    Login.route : (BuildContext context) => const Login(),
    Register.route : (BuildContext context) => const Register(),
    CreateActivity.route : (BuildContext context) => const CreateActivity(),
    CreateSubject.route : (BuildContext context) => const CreateSubject(),
    CreateTeacher.route : (BuildContext context) => const CreateTeacher(),
    Subject.route : (BuildContext context) => Subject(),
    Rate.route : (BuildContext context) => Rate(),
  };
}

WidgetBuilder error404(){
  return (BuildContext context) => const Error404();
}
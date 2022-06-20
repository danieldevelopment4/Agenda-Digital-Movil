import 'package:agenda_movil/src/pages/Error404.dart';
import 'package:agenda_movil/src/pages/Home.dart';
import 'package:agenda_movil/src/pages/Login.dart';
import 'package:agenda_movil/src/pages/Register.dart';
import 'package:agenda_movil/src/pages/createActivity.dart';
import 'package:agenda_movil/src/pages/createSubject.dart';
import 'package:agenda_movil/src/pages/createTeacher.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder>getRoutes(){
  return <String,WidgetBuilder>{
    Home.route : (BuildContext context) => const Home(),
    Login.route : (BuildContext context) => const Login(),
    Register.route : (BuildContext context) => const Register(),
    CreateActivity.route : (BuildContext context) => const CreateActivity(),
    CreateSubject.route : (BuildContext context) => const CreateSubject(),
    CreateTeacher.route : (BuildContext context) => const CreateTeacher(),
  };
}

WidgetBuilder error404(){
  return (BuildContext context) => const Error404();
}
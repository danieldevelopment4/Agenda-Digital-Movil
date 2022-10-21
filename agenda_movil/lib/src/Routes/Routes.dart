// ignore_for_file: file_names

import 'package:agenda_movil/src/pages/RatePage.dart';
import 'package:flutter/material.dart';

import 'package:agenda_movil/src/pages/Error404.dart';
import 'package:agenda_movil/src/pages/HomePage.dart';
import 'package:agenda_movil/src/pages/LogginPage.dart';
import 'package:agenda_movil/src/pages/RegisterPage.dart';
import 'package:agenda_movil/src/pages/MatterPage.dart';
import 'package:agenda_movil/src/pages/CreateActivityPage.dart';
import 'package:agenda_movil/src/pages/CreateSubjectPage.dart';
import 'package:agenda_movil/src/pages/CreateTeacherPage.dart';

Map<String, WidgetBuilder>getRoutes(){
  return <String,WidgetBuilder>{
    HomePage.HomeRoute : (BuildContext context) => HomePage(0),
    HomePage.CalendarRoute : (BuildContext context) => HomePage(1),
    LogginPage.route : (BuildContext context) => const LogginPage(),
    RegisterPage.route : (BuildContext context) => const RegisterPage(),
    CreateActivityPage.route : (BuildContext context) => const CreateActivityPage(),
    CreateSubjectPage.route : (BuildContext context) => const CreateSubjectPage(),
    CreateTeacherPage.route : (BuildContext context) => const CreateTeacherPage(),
    MatterPage.route : (BuildContext context) => MatterPage(),
    RatePage.route : (BuildContext context) => const RatePage(),
  };
}

WidgetBuilder error404(){
  return (BuildContext context) => const Error404();
}
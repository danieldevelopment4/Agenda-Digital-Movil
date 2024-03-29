// ignore_for_file: file_names

import 'package:agenda_movil/src/pages/ActivityPage.dart';
import 'package:agenda_movil/src/pages/ChangePasswordPanel.dart';
import 'package:agenda_movil/src/pages/RatePage.dart';
import 'package:agenda_movil/src/pages/RecoverPage.dart';
import 'package:agenda_movil/src/pages/SettingsPage.dart';
import 'package:agenda_movil/src/pages/TutorialPage.dart';
import 'package:flutter/material.dart';

import 'package:agenda_movil/src/pages/Error404.dart';
import 'package:agenda_movil/src/pages/HomePage.dart';
import 'package:agenda_movil/src/pages/LogginPage.dart';
import 'package:agenda_movil/src/pages/RegisterPage.dart';
import 'package:agenda_movil/src/pages/MatterPage.dart';
import 'package:agenda_movil/src/pages/CreateActivityPage.dart';
import 'package:agenda_movil/src/pages/CreateMatterPage.dart';
import 'package:agenda_movil/src/pages/TeacherPage.dart';

Map<String, WidgetBuilder>getRoutes(){
  return <String,WidgetBuilder>{
    HomePage.tableRoute : (BuildContext context) => HomePage(0),
    HomePage.homeRoute : (BuildContext context) => HomePage(1),
    HomePage.calendarRoute : (BuildContext context) => HomePage(2),
    LogginPage.route : (BuildContext context) => const LogginPage(),
    RegisterPage.route : (BuildContext context) => const RegisterPage(),
    RecoverPage.route : (BuildContext context) => const RecoverPage(),
    CreateActivityPage.route : (BuildContext context) => const CreateActivityPage(),
    CreateMatterPage.route : (BuildContext context) => const CreateMatterPage(),
    TeacherPage.createRoute : (BuildContext context) => TeacherPage(true),
    TeacherPage.editRroute : (BuildContext context) => TeacherPage(false),
    MatterPage.route : (BuildContext context) => const MatterPage(),
    ActivityPage.route: (BuildContext context) => const ActivityPage(),
    SettingsPage.route: (BuildContext context) => const SettingsPage(),
    ChangePasswordPanel.route: (BuildContext context) => const ChangePasswordPanel(),
    RatePage.route : (BuildContext context) => const RatePage(),
    TutorialPage.route : (BuildContext context) => const TutorialPage(),
  };
}

WidgetBuilder error404(){
  return (BuildContext context) => const Error404();
}
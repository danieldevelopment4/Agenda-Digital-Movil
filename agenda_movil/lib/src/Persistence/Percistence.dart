// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Percistence{

  static final Percistence _instance = Percistence._internal();

  factory Percistence(){
    return _instance;
  }

  Percistence._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    WidgetsFlutterBinding.ensureInitialized();//evita una eception que no se por que al del video no le da :?
    //slgun dia debere de entender que puercas y por que al del video no le da error, pero eso sera otro dia
    _prefs = await SharedPreferences.getInstance();
  }

  String get student{
    return _prefs.getString("Student")??"";
  }

  set student(String student) {
    _prefs.setString("Student", student);
  }

  String get subscription{
    return _prefs.getString("Subscription")??"";
  }

  set subscription(String subscription) {
    _prefs.setString("Subscription", subscription);
  }
  
  

  //?? significa, si es null retorne false

  
}
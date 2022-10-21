import 'package:agenda_movil/src/MyApp.dart';
import 'package:agenda_movil/src/Persistence/Percistence.dart';
import 'package:flutter/material.dart';

void main() async {
  Percistence _percistence = Percistence();
  await _percistence.initPrefs();
  runApp(MyApp());
}

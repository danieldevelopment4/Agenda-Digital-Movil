// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../Logic/Management.dart';
import '../Logic/Provider.dart';
import '../Widget/BottomBarMenu.dart';
import '../Widget/Menu.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const String route = "Settings";

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
   late Size _size;
  late Management _management;
  
  late TextStyle _titlle;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    _titlle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "Agenda Digital",
          style: _titlle
        ),
        
      ),
      drawer: Menu(),
      bottomNavigationBar: BottomBarMenu(),
      body: const Text("Settings")
         
    );
  }

}
// ignore_for_file: file_names

import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:flutter/material.dart';

class CreateActivityPage extends StatefulWidget {
  const CreateActivityPage({Key? key}) : super(key: key);

  static const String route = "CreateActivity";

  @override
  State<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {

  late TextStyle _appBarTitlle;

 @override
  Widget build(BuildContext context) {
    _appBarTitlle = const TextStyle(
      fontSize: 30,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "Agenda Digital",
          style: _appBarTitlle
        ),
      ),
      drawer: Menu(),
      bottomNavigationBar: BottomBarMenu(),
     body: const Center(child: Text("Actividades"))
    );
  }
}
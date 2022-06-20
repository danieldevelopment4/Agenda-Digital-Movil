import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:flutter/material.dart';

class CreateTeacher extends StatefulWidget {
  const CreateTeacher({Key? key}) : super(key: key);

  static const String route = "CreateTeacher";

  @override
  State<CreateTeacher> createState() => _CreateTeacherState();
}

class _CreateTeacherState extends State<CreateTeacher> {

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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.settings),
              iconSize: 30,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        )
      ),
      drawer: const Menu(),
      bottomNavigationBar: const BottomBarMenu(),
     body: Center(child: Text("Docentes"))
    );
  }
}
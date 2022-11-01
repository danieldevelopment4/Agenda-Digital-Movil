import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Persistence/Percistence.dart';
import 'package:agenda_movil/src/pages/TeacherPage.dart';
import 'package:agenda_movil/src/pages/LogginPage.dart';
import 'package:agenda_movil/src/pages/RatePage.dart';
import 'package:agenda_movil/src/pages/SettingsPage.dart';
import 'package:flutter/material.dart';


class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);

  late Size size;
  late ButtonStyle _buttonStyle;
  late TextStyle _headerTextStyle;
  late TextStyle _optionsStyle;

  late Management _management;

  final Percistence _percistence = Percistence();

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);

    _headerTextStyle = const TextStyle(
      fontSize: 28,
      color: Colors.white
    );
    _buttonStyle = TextButton.styleFrom(
      primary: Colors.white, //color de la letra 
      onSurface: Colors.white, //color de la letra cuando el boton esta DESACTIVADO
      backgroundColor: Colors.blue[700], 
      textStyle: const TextStyle(
        fontSize: 20,
      ),
    );
    _optionsStyle = const TextStyle(
      fontSize: 22,
    );

    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: <Widget>[
                Text(
                  _management.getStudent.name+"\n"+_management.getStudent.lastName,
                  style: _headerTextStyle
                ),
                CircleAvatar(
                  child: const Icon(Icons.account_circle, size: 50, color: Colors.white,),
                  minRadius: 25,
                  backgroundColor: Colors.green[400],
                ),
              ],
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Files/Assets/menuHeader.jpg"),
                fit: BoxFit.cover
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue[700], size: 42),
            title: Text(
              "Configuracion",
              style: _optionsStyle,
            ),
            onTap: ()async{
              await _management.subscripciptionRequest();
              _management.setIndex=-1;
              Navigator.pushReplacementNamed(context, SettingsPage.route);
            },
          ),
          ListTile(
            leading: Icon(Icons.hail_outlined, color: Colors.blue[700], size: 42),
            title: Text(
              "Agregar Docente",
              style: _optionsStyle,
            ),
            onTap: (){
              _management.setIndex=-1;
              Navigator.pushReplacementNamed(context, TeacherPage.createRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.pending_actions, color: Colors.blue[700], size: 42),
            title: Text(
              "Estudio asistido",
              style: _optionsStyle,
            ),
            onTap: (){
            },
          ),
          ListTile(
            leading: Icon(Icons.rate_review, color: Colors.blue[700], size: 42),
            title: Text(
              "Valoranos",
              style: _optionsStyle,
            ),
            onTap: (){
              Navigator.pushReplacementNamed(context, RatePage.route);
              _management.setIndex=-1;
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_search_outlined, color: Colors.blue[700], size: 42),
            title: Text(
              "Tutorial",
              style: _optionsStyle,
            ),
            onTap: (){},
          ),
          const Expanded(child: SizedBox(),),
          const Divider(),
          TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Cerrar sesion"),
                SizedBox(width: 12,),
                Icon(Icons.logout, color: Colors.white, size: 30,)
              ],
            ),
            style: _buttonStyle,
            onPressed: (){
              _percistence.student = "";
              _percistence.subscription = "";
              Navigator.pushReplacementNamed(context, LogginPage.route);
            },
          )
        ],
      ),
    );
  }
}
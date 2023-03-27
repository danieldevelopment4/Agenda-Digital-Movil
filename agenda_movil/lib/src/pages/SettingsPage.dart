// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/pages/ChangePasswordPanel.dart';
import 'package:flutter/material.dart';

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
  late TextStyle _subTitlle;
  late ButtonStyle _buttonText;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    _titlle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
    _subTitlle = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 22, color: Colors.blue[700]
    );
    _buttonText = TextButton.styleFrom(
      primary: Colors.black, //color de la letra
      onSurface: Colors.black, //color de la letra cuando el boton esta DESACTIVADO
      // backgroundColor: Colors.blue[700],
      minimumSize: Size(_size.width * .95, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      maximumSize: Size(_size.width * .95, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      textStyle: const TextStyle(
        fontSize: 20,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "Agenda Digital",
          style: _titlle
        ),
        
      ),
      drawer: const Menu(),
      bottomNavigationBar: const BottomBarMenu(),
      body: ListView(
        children: <Widget>[
          _userData(),
          // _appData(),
          _version()
        ],
      )
    );
  }

  Widget _userData(){
    return Container(
      margin: const EdgeInsets.all(7),
      child: Card(
        elevation: 10,//sombreado
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Informacion de usuario",
              style: _subTitlle,
            ),
            Divider( height: .5, thickness: 1.3, color: Colors.blue[700]),
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, ChangePasswordPanel.route);
              }, 
              child:Row(
                children: const <Widget>[
                  Icon(Icons.perm_contact_calendar_sharp, size: 30,),
                  Expanded(child: SizedBox(),),
                  Text("Modificar contraseña"),
                  Expanded(child: SizedBox(),),
                  Icon(Icons.arrow_forward_ios, size: 30,)
                ],
              ),
              style: _buttonText,
            ),
            // Divider( height: .5, thickness: 1.3, color: Colors.blue[700]),
            // TextButton(
            //   onPressed: (){}, 
            //   child:Row(
            //     children: const <Widget>[
            //       Icon(Icons.color_lens, size: 30,),
            //       Expanded(child: SizedBox(),),
            //       Text("Modificar color"),
            //       Expanded(child: SizedBox(),),
            //       Icon(Icons.arrow_forward_ios, size: 30,)
            //     ],
            //   ),
            //   style: _buttonText,
            // )
          ]
        ),
      ),
    );
  }

  Widget _appData(){
    return Container(
      margin: const EdgeInsets.all(7),
      child: Card(
        elevation: 10,//sombreado
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Configuracion del app",
              style: _subTitlle,
            ),
            Divider( height: .5, thickness: 1.3, color: Colors.blue[700]),
            TextButton(
              onPressed: (){}, 
              child:Row(
                children: const <Widget>[
                  Icon(Icons.brightness_medium, size: 30,),
                  Expanded(child: SizedBox(),),
                  Text("Cambiar tema"),
                  Expanded(child: SizedBox(),),
                  Icon(Icons.arrow_forward_ios, size: 30,)
                ],
              ),
              style: _buttonText,
            ),
            Divider( height: .5, thickness: 1.3, color: Colors.blue[700]),
            TextButton(
              onPressed: (){}, 
              child:Row(
                children: const <Widget>[
                  Icon(Icons.language, size: 30,),
                  Expanded(child: SizedBox(),),
                  Text("Cambiar lenguaje"),
                  Expanded(child: SizedBox(),),
                  Icon(Icons.arrow_forward_ios, size: 30,)
                ],
              ),
              style: _buttonText,
            ),
          ]
        ),
      ),
    );
  }

  Widget _version(){
    return Container(
      margin: const EdgeInsets.all(7),
      child: Card(
        elevation: 10,//sombreado
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Version de la app",
              style: _subTitlle,
            ),
            Text(
              "V: "+_management.getVersion,
              // style: _subTitlle,
            ),
            Divider( height: .5, thickness: 1.3, color: Colors.blue[700]),
            TextButton(
              onPressed: (){}, 
              child:Row(
                children: const <Widget>[
                  Icon(Icons.system_update, size: 30,),
                  Expanded(child: SizedBox(),),
                  Text("Buscar actualizacion"),
                  Expanded(child: SizedBox(),),
                  Icon(Icons.arrow_forward_ios, size: 30,)
                ],
              ),
              style: _buttonText,
            ),
          ]
        ),
      ),
    );
  }

}
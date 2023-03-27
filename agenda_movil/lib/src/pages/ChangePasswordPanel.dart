// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';

import '../Widget/BottomBarMenu.dart';
import '../Widget/Menu.dart';

class ChangePasswordPanel extends StatefulWidget {
  const ChangePasswordPanel({Key? key}) : super(key: key);

  static const String route = "ChangePassword";

  @override
  State<ChangePasswordPanel> createState() => _ChangePasswordPanelState();
}

class _ChangePasswordPanelState extends State<ChangePasswordPanel> {

  late Size _size;
  late Management _management;

  late TextStyle _titlle;
  late TextStyle _notificationTitle;
  late TextStyle _notificationText;
  late ButtonStyle _buttonText;

  bool _passwordVisible= false;

  final TextEditingController _passwordTextField = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    _titlle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
    _notificationTitle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold
    );
    _notificationText = const TextStyle(
      fontSize: 15,
    );
    _buttonText = TextButton.styleFrom(
      primary: Colors.white, //color de la letra
      onSurface: Colors.white, //color de la letra cuando el boton esta DESACTIVADO
      backgroundColor: Colors.blue[700],
      minimumSize: Size(_size.width * .9, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      maximumSize: Size(_size.width * .9, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      textStyle: const TextStyle(
        fontSize: 18,
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
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  const Text(
                    "No te preocupes por cuantas veces necesites cambiar tu contraseña, entendemos que tu "
                    "seguridad y privacidad es lo primero y por ello no te damos un limite de cambios",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  StreamBuilder(
                    stream: _management.streams.studentPasswordStream,
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextField(
                        controller: _passwordTextField,
                        enableInteractiveSelection: false, //Impide copiar cosas
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          label: const Text("Contraseña"),
                          errorText: (snapshot.error.toString() != "null")? snapshot.error.toString(): null,
                          errorStyle: const TextStyle(color: Colors.red),
                          icon: Icon(
                            Icons.password,
                            color: Colors.blue[700],
                          ), //icono de la izquierda
                          suffixIcon: IconButton(
                            icon: Icon( (_passwordVisible) ? Icons.visibility : Icons.visibility_off, color: Colors.blue[700],),
                            onPressed: () {
                              _passwordVisible = !_passwordVisible;
                              setState(() {});
                            }
                          ),
                        ),
                        onChanged: _management.streams.changeStudentPassword,
                      );
                    },
                  ),
                  const Expanded(child: SizedBox()),
                  
                ],
              ),
            ),
            StreamBuilder(
              stream: _management.streams.studentPasswordStream,
              builder:(BuildContext context, AsyncSnapshot<String> snapshot) {
                return TextButton(
                  onPressed: (snapshot.hasData)? () {
                    changePasswordRequest();
                  }: null,
                  child: const Text("Cambiar contraseña\t"),
                  style: _buttonText,
                );
              },
            ),
          ],
        ),
      )
    );
  }

  void changePasswordRequest()async{
    Map<String, dynamic> response = await _management.setNewPasswordRequest();
    _notificateRequest(response);
    _management.streams.resetPassword();
    _passwordTextField.text = "";
  }

  void _notificateRequest(Map<String, dynamic> response)async{
    if (response["status"]) {
      await _management.viewSubscripciptionsRequest();
      ElegantNotification.success(
        title: Text("Accion exitosa", style: _notificationTitle,),
        description:  Text(response["message"], style: _notificationText,),
        toastDuration: const Duration(seconds: 2, milliseconds: 500)
      ).show(context);
      setState(() {});
    } else {
      if(response["type"]=="info"){
        ElegantNotification.info(
          title: Text("Informacion", style: _notificationTitle,),
          description:  Text(response["message"], style: _notificationText,),
          toastDuration: const Duration(seconds: 4),
        ).show(context);
      }else{
        ElegantNotification.error(
          title: Text("Error", style: _notificationTitle,),
          description:  Text(response["message"], style: _notificationText,),
          toastDuration: const Duration(seconds: 3, milliseconds: 500)
        ).show(context);
      }
    }
  }

}
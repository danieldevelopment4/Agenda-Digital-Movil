// ignore_for_file: file_names

import 'dart:math';

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/pages/LogginPage.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const String route = "Register";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Size _size;
  late TextStyle _subTitlle;
  late ButtonStyle _buttonText;
  late TextStyle _dialogText;
  late Management _management;
  bool _passwordVisible= false;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size; //dimeiones de la pantalla
    _management = Provider.of(context);
    _subTitlle = TextStyle(
        fontWeight: FontWeight.w700, fontSize: 22, color: Colors.blue[700]);
    _dialogText = const TextStyle(
      fontSize: 24,
    );
    _buttonText = TextButton.styleFrom(
      primary: Colors.white, //color de la letra
      onSurface:
          Colors.white, //color de la letra cuando el boton esta DESACTIVADO
      backgroundColor: Colors.blue[700],
      minimumSize: Size(_size.width * .4,
          40), //tamaño minimo deo boton, con esto todos quedaran iguales
      maximumSize: Size(_size.width * .4,
          40), //tamaño minimo deo boton, con esto todos quedaran iguales
      textStyle: const TextStyle(
        fontSize: 18,
      ),
    );
    _management = Provider.of(context);

    return Scaffold(
        body: Stack(
      children: <Widget>[_back(context), _register(context)],
    ));
  }

  Widget _back(BuildContext context) {
    final size = MediaQuery.of(context).size; //dimeiones de la pantalla
    return Stack(children: <Widget>[
      Container(
        //fondo morado
        height: (size.width > size.height)
            ? size.height * 0.55
            : size.height * 0.45,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0, 0),
                end: Alignment(1, 1),
                colors: <Color>[
              Color.fromARGB(255, 45, 45, 232),
              Color.fromRGBO(13, 71, 161, 1)
            ])),
      ),
      Container(
        padding: EdgeInsets.only(top: size.height * .1212),
        child: const Image(
          image: AssetImage("Files/Assets/LogoB.png"),
        ),
      )
    ]);
  }

  Widget _register(BuildContext context) {
    final size = MediaQuery.of(context).size; //dimeiones de la pantalla

    return ListView(
      children: [
        Column(children: [
          const SizedBox(
            height: 300,
            width: double.infinity,
          ),
          Container(
            width: size.width * .85,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.blue[700]!,
                      blurRadius: 20, //nivel de difuminado
                      offset: const Offset(0, 5), //posicion
                      spreadRadius: 5 //agrandar la caja
                      )
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  "Se parte de nuestra comunidad",
                  style: _subTitlle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                StreamBuilder(//NOMBRE
                  stream: _management.streams.nameStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: "Daniel",
                        label: const Text("Nombre"),
                        errorText: (snapshot.error.toString() != "null")
                            ? snapshot.error.toString()
                            : null,
                        errorStyle: const TextStyle(color: Colors.red),
                        icon: Icon(
                          Icons.text_fields_sharp,
                          color: Colors.blue[700],
                        ), //icono de la izquierda
                      ),
                      onChanged: _management.streams.changeName,
                    );
                  },
                ),
                const SizedBox(height: 12),
                StreamBuilder(//APELLIDO
                  stream: _management.streams.lastNameStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: "Gomez",
                        label: const Text("Apellido"),
                        errorText: (snapshot.error.toString() != "null") ? snapshot.error.toString() : null,
                        errorStyle: const TextStyle(color: Colors.red),
                        icon: Icon(
                          Icons.text_fields_sharp,
                          color: Colors.blue[700],
                        ), //icono de la izquierda
                      ),
                      onChanged: _management.streams.changeLastName,
                    );
                  },
                ),
                const SizedBox(height: 12),
                StreamBuilder(//EMAIL
                  stream: _management.streams.emailStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "daga70414@gmail.com",
                        label: const Text("Correo"),
                        errorText: (snapshot.error.toString() != "null")
                            ? snapshot.error.toString()
                            : null,
                        errorStyle: const TextStyle(color: Colors.red),
                        icon: Icon(
                          Icons.alternate_email,
                          color: Colors.blue[700],
                        ), //icono de la izquierda
                      ),
                      onChanged: _management.streams.changeEmail,
                    );
                  },
                ),
                const SizedBox(height: 12),
                StreamBuilder(//CONTRASEÑA
                  stream: _management.streams.passwordStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      enableInteractiveSelection: false, //Impide copiar cosas
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        label: const Text("Contraseña"),
                        errorText: (snapshot.error.toString() != "null")
                            ? snapshot.error.toString()
                            : null,
                        errorStyle: const TextStyle(color: Colors.red),
                        icon: Icon(
                          Icons.password,
                          color: Colors.blue[700],
                        ),
                        suffixIcon: IconButton(
                          icon: Icon( (_passwordVisible) ? Icons.visibility : Icons.visibility_off, color: Colors.blue[700],),
                          onPressed: () {
                            _passwordVisible = !_passwordVisible;
                            setState(() {});
                          }
                        ), //icono de la izquierda
                      ),
                      onChanged: _management.streams.changePassword,
                    );
                  },
                ),
                const SizedBox(height: 30),
                StreamBuilder(
                  stream: _management.streams.buttonRegisterStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return TextButton(
                      onPressed: (snapshot.hasData)?(){registerRequest(context);}:null,
                      child: const Text(
                        "Registrarse",
                      ),
                      style: _buttonText,
                    );
                  },
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, LogginPage.route),
                  child: const Text(
                    "Cancelar",
                  ),
                  style: _buttonText,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 70,
            width: double.infinity,
          ),
          TextButton(
            onPressed: () {},
            child: const Text("¿Olvido la contraseña?"),
            style: TextButton.styleFrom(
                primary: Colors.blue[700], //color de la letra
                onSurface: Colors.blue[
                    700], //color de la letra cuando el boton esta DESACTIVADO
                minimumSize: Size(size.width * .1,
                    40) //tamaño minimo deo boton, con esto todos quedaran iguales
                ),
          )
        ]),
      ],
    );
  }

  void registerRequest(BuildContext context) async {
    Map<String, String> body = {
      "name": _management.streams.name,
      "lastName": _management.streams.lastName,
      "email": _management.streams.email,
      "password": _management.streams.password
    };
    Map<String, dynamic> response = await _management.registerRequest(body);
    // print("STATUS::" + response["status"].toString());
    if (response["status"]) {
      _showAlert( context, Icons.verified,  const Color.fromARGB(255, 133, 213, 42), const Color.fromRGBO(3, 133, 14, 1), response["message"], "Continuar", _logginSuccessful);
      // print(response["message"]);
      //
    } else {
      _showAlert( context, Icons.back_hand, const Color.fromRGBO(213, 5, 5, 1), const Color.fromRGBO(85, 2, 16, 1), response["message"], "Aceptar", _logginDeclined);
      // print("ERROR");
      // print(response["message"]);
    }
  }

  void _showAlert(BuildContext context, IconData icon, Color color1, Color color2, String message, String textButton, Function toDo) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const SizedBox(
                  height: 35,
                ),
                Stack(
                  children: <Widget>[
                    Center(
                      child: Transform.rotate(
                        //rotacion
                        angle: -pi / 1.4,
                        child: Container(
                          //caja rosada
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius:const BorderRadius.all(Radius.circular(40)),
                            gradient: RadialGradient(
                              radius: 1.4,
                              center: Alignment.topLeft,
                              colors: <Color>[
                                color1,
                                color2
                              ]
                            )
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(
                        icon,
                        size: 180,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: _dialogText,
                ),
                TextButton(
                    onPressed: () => toDo(context),
                    child: Text(
                      textButton,
                      style: _dialogText,
                    ))
              ],
            ),
          );
        });
  }

  void _logginSuccessful(BuildContext context) {
    // print("_logginSuccessful");
    Navigator.pushReplacementNamed(context, HomePage.HomeRoute);
  }

  void _logginDeclined(BuildContext context) {
    // print("_logginDeclined");
    Navigator.pop(context);
  }
}
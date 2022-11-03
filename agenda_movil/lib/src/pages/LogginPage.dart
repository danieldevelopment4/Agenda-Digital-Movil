// ignore_for_file: file_names

import 'dart:math';

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/pages/RegisterPage.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class LogginPage extends StatefulWidget {
  const LogginPage({Key? key}) : super(key: key);

  static const String route = "Login";

  @override
  State<LogginPage> createState() => _LogginPageState();
}

class _LogginPageState extends State<LogginPage> {
  late Size _size;
  late Management _management;
  
  late TextStyle _subTitlle;
  late ButtonStyle _buttonText;
  late ButtonStyle _outSideButtonText;
  late TextStyle _dialogText;

  final TextEditingController _emailTextField = TextEditingController();
  final TextEditingController _passwordTextField = TextEditingController();

  bool _passwordVisible= false;
  bool _load = false;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size; //dimeiones de la pantalla
    _management = Provider.of(context);
    _dialogText = const TextStyle(
      fontSize: 24,
    );
    _subTitlle = TextStyle(
        fontWeight: FontWeight.w700, fontSize: 22, color: Colors.blue[700]);
    _buttonText = TextButton.styleFrom(
      primary: Colors.white, //color de la letra
      onSurface: Colors.white, //color de la letra cuando el boton esta DESACTIVADO
      backgroundColor: Colors.blue[700],
      minimumSize: Size(_size.width * .55, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      maximumSize: Size(_size.width * .55, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      textStyle: const TextStyle(
        fontSize: 18,
      ),
    );
    _outSideButtonText = TextButton.styleFrom(
      primary: Colors.blue[700], //color de la letra
      onSurface:
          Colors.blue[700], //color de la letra cuando el boton esta DESACTIVADO
      textStyle: const TextStyle(
        fontSize: 18,
      ),
    );

    return Scaffold(
        body: Stack(
      children: [_back(context), _login(context)],
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
              Color.fromRGBO(13, 71, 161, 1),
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

  Widget _login(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 300,
              width: double.infinity,
            ),
            Container(
              width: _size.width * .85,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.blue[700]!,
                        blurRadius: 20, //nivel de difuminado
                        offset: const Offset(0, 5), //posicion
                        spreadRadius: 8 //agrandar la caja
                        )
                  ]),
              child: Column(
                children: <Widget>[
                  Text(
                    "Inicio de sesion",
                    style: _subTitlle,
                  ),
                  const SizedBox(height: 30),
                  StreamBuilder(
                    stream: _management.streams.studentEmailStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextField(
                        controller: _emailTextField,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "daga70414@gmail.com",
                          label: const Text("Correo"),
                          errorText: (snapshot.error.toString() != "null")? snapshot.error.toString(): null,
                          errorStyle: const TextStyle(color: Colors.red),
                          icon: const Icon(
                            Icons.alternate_email,
                            color: Color.fromRGBO(13, 71, 161, 1),
                          ), //icono de la izquierda
                        ),
                        onChanged: _management.streams.changeStudentEmail,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  StreamBuilder(
                    stream: _management.streams.studentPasswordStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                  const SizedBox(height: 30),
                  StreamBuilder(
                    stream: _management.streams.buttonLoginStream,
                    builder:(BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return TextButton(
                        onPressed: (snapshot.hasData)? () {
                          setState(() {
                            _load = true;
                          });
                          logginRequest();
                        }: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Iniciar sesion\t"),
                            (_load)?_loading():const Text(""),
                          ],
                        ),
                        style: _buttonText,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, RegisterPage.route),
                    child: const Text(
                      "Registrarse",
                    ),
                    style: _buttonText,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: null,
                    child: const Text(
                      "Google Login",
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
              child: const Text("¿Olvidaste tu contraseña?"),
              style: _outSideButtonText,
            )
          ]
        ),
      ],
    );
  }

  Widget _loading(){
    return const CircularProgressIndicator(
      color: Colors.white,
      strokeWidth: 4,
    );
  }

  void logginRequest() async {
    
    Map<String, dynamic> response = await _management.logingRequest();
    if (response["status"]) {
      _management.setStudent();
      await _management.viewSubscripciptionsRequest();
      Navigator.pushReplacementNamed(context, HomePage.HomeRoute);
    } else {
      setState(() {
        _management.streams.resetEmail();
        _emailTextField.text="";
        _management.streams.resetPassword();
        _passwordTextField.text="";
        _load=false;
      });
      // print("ERROR");
      _showAlert(context, Icons.back_hand, const Color.fromRGBO(213, 5, 5, 1),
          const Color.fromRGBO(85, 2, 16, 1), response["message"], "Aceptar");
    }
  }

  void _showAlert(BuildContext context, IconData icon, Color color1, Color color2, String message, String textButton) {
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            gradient: RadialGradient(
                                radius: 1.4,
                                center: Alignment.topLeft,
                                colors: <Color>[color1, color2])),
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
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    textButton,
                    style: _dialogText,
                  ))
            ],
          ),
        );
      }
    );
  }
}

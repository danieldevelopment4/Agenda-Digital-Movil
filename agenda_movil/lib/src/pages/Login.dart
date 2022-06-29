import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/pages/Register.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  static const String route = "Login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  late Size _size;
  late TextStyle _subTitlle;
  late ButtonStyle _buttonText;
  late ButtonStyle _outSideButtonText;
  late Management _management;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    _subTitlle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: Colors.blue[700]
    );
    _buttonText = TextButton.styleFrom(
      primary: Colors.white, //color de la letra 
      onSurface: Colors.white, //color de la letra cuando el boton esta DESACTIVADO
      backgroundColor: Colors.blue[700], 
      minimumSize: Size(_size.width*.4, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      maximumSize: Size(_size.width*.4, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      textStyle: const TextStyle(
        fontSize: 18,
      ),
    );
    _outSideButtonText = TextButton.styleFrom(
      primary: Colors.blue[700], //color de la letra 
      onSurface: Colors.blue[700], //color de la letra cuando el boton esta DESACTIVADO
      textStyle: const TextStyle(
        fontSize: 18,
      ),
    );
    

    return Scaffold(
      body: Stack(
        children: [
          _back(context),
          _login(context)
        ],
      )
    );
  }

  Widget _back(BuildContext context){
    final size = MediaQuery.of(context).size;//dimeiones de la pantalla
    return Stack(
      children: <Widget>[
        Container(//fondo morado
          height: (size.width>size.height)?size.height*0.55:size.height*0.45,
          width: double.infinity,
          decoration:const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, 0),
              end: Alignment(1, 1),
              colors: <Color> [
                Color.fromRGBO(13, 71, 161, 1),
                Color.fromRGBO(13, 71, 161, 1)    
              ]
            )
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: size.height*.1212),
          child: const Image(
            image: AssetImage("Files/Assets/LogoB.png"),
          ),
        )
      ]
    );
  }

  Widget _login(BuildContext context){

    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(height:300, width: double.infinity,),
            Container(
              width: _size.width*.85,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.blue[700]!,
                    blurRadius: 20,//nivel de difuminado
                    offset: const Offset(0, 5),//posicion
                    spreadRadius: 8//agrandar la caja
                  )
                ]
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Inicio de sesion",
                    style: _subTitlle,
                  ),
                  const SizedBox(height: 30),
                  StreamBuilder(
                    stream: _management.emailStream, 
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "daga70414@gmail.com",
                          label: const Text("Correo"), 
                          errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                          errorStyle: const TextStyle(color: Colors.red),
                          icon: const Icon(Icons.alternate_email, color: Color.fromRGBO(13, 71, 161, 1),),//icono de la izquierda
                        ),
                        onChanged: _management.changeEmail,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  StreamBuilder(
                    stream: _management.passwordStream, 
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
                      return TextField(
                        enableInteractiveSelection: false,//Impide copiar cosas
                        obscureText: true,
                        decoration: InputDecoration(
                          label: const Text("Contraseña"), 
                          errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                          errorStyle: const TextStyle(color: Colors.red),
                          icon: Icon(Icons.password, color: Colors.blue[700],),//icono de la izquierda
                        ),
                        onChanged: _management.changePassword,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  StreamBuilder(
                    stream: _management.buttonLoginStream, 
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {  
                      return TextButton(
                        onPressed: (snapshot.hasData)?(){Navigator.pushReplacementNamed(context, Home.HomeRoute);}:null,
                        child: const Text("Iniciar sesion",),
                        style: _buttonText,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, Register.route),
                    child: const Text("Registrarse",),
                    style: _buttonText,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: null,
                    child: const Text("Google Login",),
                    style: _buttonText,
                  )
                ],
              ),
            ),
            const SizedBox(height:70, width: double.infinity,),
            TextButton(
              onPressed: (){},
              child: const Text("¿Olvidaste tu contraseña?"),
              style: _outSideButtonText,
            )
          ]
        ),
      ],
    );
  }
}
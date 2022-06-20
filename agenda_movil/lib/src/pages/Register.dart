import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/pages/Login.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  static const String route = "Register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  late Size size;
  late TextStyle subTitlle;
  late ButtonStyle buttonText;
  late Management management;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;//dimeiones de la pantalla
    subTitlle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: Colors.blue[700]
    );
    buttonText = TextButton.styleFrom(
      primary: Colors.white, //color de la letra 
      onSurface: Colors.white, //color de la letra cuando el boton esta DESACTIVADO
      backgroundColor: Colors.blue[700], 
      minimumSize: Size(size.width*.4, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      maximumSize: Size(size.width*.4, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      textStyle: const TextStyle(
        fontSize: 16,
      ),
    );
    management = Provider.of(context);

    return Scaffold(
      body: Stack(
        children: [
          _back(context),
          _register(context)
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
                Color.fromARGB(255, 45, 45, 232),
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

  Widget _register(BuildContext context){

    final management = Provider.of(context);

    final size = MediaQuery.of(context).size;//dimeiones de la pantalla

    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(height:300, width: double.infinity,),
            Container(
              width: size.width*.85,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.blue[700]!,
                    blurRadius: 20,//nivel de difuminado
                    offset: const Offset(0, 5),//posicion
                    spreadRadius: 5//agrandar la caja
                  )
                ]
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Se parte de nuestra comunidad",
                    style: subTitlle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  StreamBuilder(
                    stream: management.emailStream, 
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "daga70414@gmail.com",
                          label: const Text("Correo"), 
                          errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                          errorStyle: const TextStyle(color: Colors.red),
                          icon: Icon(Icons.alternate_email, color: Colors.blue[700],),//icono de la izquierda
                        ),
                        onChanged: management.changeEmail,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  StreamBuilder(
                    stream: management.passwordStream, 
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
                        onChanged: management.changePassword,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  StreamBuilder(
                    stream: management.passwordConfirmationStream, 
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
                        onChanged: management.changePasswordConfirmation,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  StreamBuilder(
                    stream: management.buttonRegisterStream, 
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {  
                      return TextButton(
                        onPressed: (snapshot.hasData)?(){Navigator.pushReplacementNamed(context, Home.route);}:null,
                        child: const Text("Registrarse",),
                        style: buttonText,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, Login.route),
                    child: const Text("Cancelar",),
                    style: buttonText,
                  )
                ],
              ),
            ),
            const SizedBox(height:70, width: double.infinity,),
            TextButton(
              onPressed: (){},
              child: const Text("¿Olvido la contraseña?"),
              style: TextButton.styleFrom(
                primary: Colors.blue[700], //color de la letra 
                onSurface: Colors.blue[700], //color de la letra cuando el boton esta DESACTIVADO
                minimumSize: Size(size.width*.1, 40) //tamaño minimo deo boton, con esto todos quedaran iguales
              ),
            )
          ]
        ),
      ],
    );
  }
}
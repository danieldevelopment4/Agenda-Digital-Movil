// ignore_for_file: file_names

import 'package:agenda_movil/src/pages/LogginPage.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';

import '../Logic/Management.dart';
import '../Logic/Provider.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({Key? key}) : super(key: key);

  static const String route = "recover";

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
   late Size _size;
  late Management _management;
  
  late TextStyle _subTitlle;
  late TextStyle _cardSubText;
  late TextStyle _notificationTitle;
  late TextStyle _notificationText;
  late ButtonStyle _buttonText;

  final TextEditingController _emailTextField = TextEditingController();
  bool _load = false;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    _subTitlle = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 22, color: Colors.blue[700]
    );
    _cardSubText = const TextStyle(
      fontSize: 16,
    );
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
    _notificationTitle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold
    );
    _notificationText = const TextStyle(
      fontSize: 15,
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

  Widget _back(BuildContext context) {
    final size = MediaQuery.of(context).size; //dimenciones de la pantalla
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
          image: AssetImage("assets/images/LogoB.png"),
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
                    "Recuperacion de contraseña",
                    style: _subTitlle,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Para poder recuperar el acceso a tu cuenta ingresa tu direccion de corre al "
                    "cual te enviaremos una nueva contraseña",
                    style: _cardSubText,
                  ),
                  StreamBuilder(
                    stream: _management.streams.studentEmailStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextField(
                        controller: _emailTextField,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "TuCorreo@gmail.com",
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
                    stream: _management.streams.studentEmailStream,
                    builder:(BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextButton(
                        onPressed: (snapshot.hasData)? () {
                          setState(() {
                            _load = true;
                          });
                          recoverRequest();
                        }: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Recuperar\t"),
                            (_load)?_loading():const Text(""),
                          ],
                        ),
                        style: _buttonText,
                      );
                    },
                  ),     
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, LogginPage.route);
                    },
                    child: const Text("Regresar"),
                    style: _buttonText,
                  )            
                ],
              ),
            ),
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

  void recoverRequest()async{
    Map<String, dynamic> response = await _management.recoverPasswordRequest();
    _notificateRequest(response);
    setState(() {
      _emailTextField.text = "";
      _management.streams.resetEmail();
      _load = false;
    });
  }

  void _notificateRequest(Map<String, dynamic> response)async{
    if (response["status"]) {
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
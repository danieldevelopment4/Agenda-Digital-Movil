// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';

class TeacherPage extends StatefulWidget {
  TeacherPage(bool create, {Key? key}) : super(key: key){
    _create = create;
  }

  late final bool _create;
  static const String createRoute = "CreateTeacher";
  static const String editRroute = "EditTeacher";

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {

  late Size _size;
  late Management _management;

  late TextStyle _notificationTitle;
  late TextStyle _notificationText;
  late TextStyle _appBarTitlle;
  late TextStyle _subTitlle;
  late ButtonStyle _sendButton;

  final TextEditingController _nameTextField = TextEditingController();
  final TextEditingController _lastnameTextField = TextEditingController();
  final TextEditingController _emailTextField = TextEditingController();
  final TextEditingController _cellphoneTextField = TextEditingController();

  bool _createTeacherLoading = false;
  bool _updateTeacherLoading = false;

  bool _create = true;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    _appBarTitlle = const TextStyle(
      fontSize: 30,
    );
    _notificationTitle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold
    );
    _notificationText = const TextStyle(
      fontSize: 15,
    );
     _subTitlle = TextStyle(
      color: Colors.blue[700],
      fontSize: 30,
    );
    _sendButton = TextButton.styleFrom(
      primary: Colors.white, //color de la letra 
      onSurface: Colors.white, //color de la letra cuando el boton esta DESACTIVADO
      backgroundColor: Colors.blue[700], 
      minimumSize: Size(_size.width*.9, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      maximumSize: Size(_size.width*.9, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      textStyle: const TextStyle(
        fontSize: 18,
      ),
    );
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "Agenda Digital",
          style: _subTitlle
        ),
      ),
      drawer: Menu(),
      bottomNavigationBar:  BottomBarMenu(),
     body: Column(
      children: <Widget>[
        Text(
          (_create)?"Registrar nuevo docente":"Actualizar Docente",
          style: _subTitlle,
        ),
        Expanded(
          child: ListView(
            children: [
              _textFields(),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        _sendRegister(),
        const SizedBox(height: 10,)
      ],
     )
    );
  }

  Widget _textFields(){
    Container textFields = Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: _management.streams.teacherNameStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
              return TextField(
                controller: _nameTextField,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Daniel Alejandro",
                  label: const Text("Nombre del docente"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                onChanged: _management.streams.changeTeacherName,
              );
            },
          ),
          const SizedBox(height: 12),
          StreamBuilder(
            stream: _management.streams.teacherLastNameStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
              return TextField(
                controller: _lastnameTextField,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Gómez Acero",
                  label: const Text("Apellido del docente"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                onChanged: _management.streams.changeTeacherLastName,
              );
            },
          ),
          const SizedBox(height: 12),
          StreamBuilder(
            stream: _management.streams.teacherEmailStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
              return TextField(
                controller: _emailTextField,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "daga70414@gmail.com",
                  label: const Text("Correo del docente"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                onChanged: _management.streams.changeTeacherEmail,
              );
            },
          ),
          const SizedBox(height: 12),
          StreamBuilder(
            stream: _management.streams.teacherCellphoneStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
              return TextField(
                controller: _cellphoneTextField,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "3007798350",
                  label: const Text("Celular del docente"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                onChanged: _management.streams.changeTeachereCellphone,
              );
            },
          ),
          const SizedBox(height: 12),
        ]
      ),
    );
    if(!widget._create){//create es falso, es decir, vamos a editar
      _create = false;
      _serachTeacherRequest();
    }
    return textFields;
  }

  Widget _sendRegister(){
    return StreamBuilder(
      stream: _management.streams.buttonCreateTeacherStream, 
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {  
        return TextButton(
          onPressed: (snapshot.hasData)?(){
            (_create)?_createTeacherRequest():_updateTeacherRequest();
          }:null,
          child: (_createTeacherLoading)?_loading():Text((_create)?"Registrar Docente":"Actualizar Docente",),
          style: _sendButton,
        );
      },
    );
  }

  void _createTeacherRequest()async{
    setState(() {
      _createTeacherLoading=true;
    });

    Map<String, dynamic> response = await _management.createTeacherRequest();
    _createTeacherLoading=false;
    reset();
    _notificateRequest(response);
  }

  void _updateTeacherRequest()async{
    setState(() {
      _updateTeacherLoading=true;
    });

    Map<String, dynamic> response = await _management.createTeacherRequest();
    _updateTeacherLoading=false;
    _notificateRequest(response);
    Navigator.pop(context);
  }

  void _serachTeacherRequest()async{
    Map<String, dynamic> response = await _management.searchTeacherRequest();
    if (response["status"]) {
      _nameTextField.text = response["body"]["name"];
      _management.streams.changeTeacherName(response["body"]["name"]);
      _lastnameTextField.text = response["body"]["lastName"];
      _management.streams.changeTeacherLastName(response["body"]["lastName"]);
      _emailTextField.text = response["body"]["email"];
      _management.streams.changeTeacherEmail(response["body"]["email"]);
      _cellphoneTextField.text = (response["body"]["cellphone"]==null)?"":response["body"]["email"];
      _management.streams.changeTeachereCellphone((response["body"]["cellphone"]==null)?"":response["body"]["email"]);
    }else{
      _notificateRequest(response);
    }
    setState(() {});
  }

   Widget _loading(){
    return const CircularProgressIndicator(
      color: Colors.white,
      strokeWidth: 4,
    );
  }

  void _notificateRequest(Map<String, dynamic> response){
    if (response["status"]) {
      _management.subscripciptionRequest();
      setState((){});
      ElegantNotification.success(
        title: Text("Accion exitosa", style: _notificationTitle,),
        description:  Text(response["message"], style: _notificationText,),
        toastDuration: const Duration(seconds: 2, milliseconds: 500)
      ).show(context);
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

  void reset(){
    setState(() {
      _management.streams.resetTeacherName();
      _nameTextField.text="";
      _management.streams.resetTeacherLastName();
      _lastnameTextField.text="";
      _management.streams.resetTeacherEmail();
      _emailTextField.text="";
      _management.streams.resetTeacherCellphone();
      _cellphoneTextField.text="";
    });
  }

}
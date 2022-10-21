// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:flutter/material.dart';

class CreateTeacherPage extends StatefulWidget {
  const CreateTeacherPage({Key? key}) : super(key: key);

  static const String route = "CreateTeacher";

  @override
  State<CreateTeacherPage> createState() => _CreateTeacherPageState();
}

class _CreateTeacherPageState extends State<CreateTeacherPage> {

  late Size _size;
  late Management _management;
  late TextStyle _appBarTitlle;
  late TextStyle _subTitlle;
  late ButtonStyle _sendButton;
  final TextEditingController _textEditingController = TextEditingController();
  
  String _notes ="";
  var _error =null;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    _appBarTitlle = const TextStyle(
      fontSize: 30,
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
          "Registrar nuevo docente",
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
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: _management.streams.emailStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
              return TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Daniel Alejandro",
                  label: const Text("Nombre del docente"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                onChanged: _management.streams.changeEmail,
              );
            },
          ),
          const SizedBox(height: 12),
          StreamBuilder(
            stream: _management.streams.emailStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
              return TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Gómez Acero",
                  label: const Text("Apellido del docente"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                onChanged: _management.streams.changeEmail,
              );
            },
          ),
          const SizedBox(height: 12),
          StreamBuilder(
            stream: _management.streams.emailStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
              return TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "daga70414@gmail.com",
                  label: const Text("Correo del docente"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                onChanged: _management.streams.changeEmail,
              );
            },
          ),
          const SizedBox(height: 12),
          StreamBuilder(
            stream: _management.streams.emailStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
              return TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "3007798350",
                  label: const Text("Celular del docente"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                onChanged: _management.streams.changeEmail,
              );
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: "Horario de atencion, Cubiculo",
              label: const Text("Anotaciones"), 
              counter: Text(_notes.length.toString()),
              errorText: _error,
              errorStyle: const TextStyle(color: Colors.red),
            ),
            onChanged: (String value){
              
              if(value.length<140){
                _error=null;
                _notes = value;
              }else{
                _error="Has llegado al limite de caracteres permitidos";
                _textEditingController.text=_notes;
              }
              
              setState(() {});
            },
          ),
        ]
      ),
    );
  }

  Widget _sendRegister(){
    return StreamBuilder(
      stream: _management.streams.buttonRegisterStream, 
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {  
        return TextButton(
          onPressed: (snapshot.hasData)?(){print("Registrar materia");}:null,
          child: const Text("Registrar Docente",),
          style: _sendButton,
        );
      },
    );
  }

}
// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CreateSubjectPage extends StatefulWidget {
  const CreateSubjectPage({Key? key}) : super(key: key);

  static const String route = "CreateSubject";

  @override
  State<CreateSubjectPage> createState() => _CreateSubjectPageState();
}

class _CreateSubjectPageState extends State<CreateSubjectPage> {

  late Size _size;
  late TextStyle _appBarTitlle;
  late TextStyle _subTitlle;
  late TextStyle _text;
  late TextStyle _cardText;
  late TextStyle _cardSubText;
  late Management _management;
  late Color _color;
  late ButtonStyle _colorButton;
  late ButtonStyle _sendButton;

  @override
  void initState() {
    _color = Colors.deepPurple;
  }
  
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
    _text = const TextStyle(
      fontSize: 20,
    );
    _cardText = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    _cardSubText = const TextStyle(
      fontSize: 18,
    );
    _colorButton = TextButton.styleFrom(
      backgroundColor: _color, 
      minimumSize: const Size(65, 38), //tamaño minimo deo boton, con esto todos quedaran iguales
      maximumSize: const Size(65, 38), //tamaño minimo deo boton, con esto todos quedaran iguales
      shape: const StadiumBorder()
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
      bottomNavigationBar: BottomBarMenu(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            Text(
              "Buscar materia por ID",
              style: _subTitlle,
            ),
            _search(),
            const Divider(),
            Text(
              "Registrar nueva materia",
              style: _subTitlle,
            ),
            _registerSubsect(context),
            _sendRegister(),
            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  Widget _search(){
    return Row(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
            stream: _management.streams.subjectIdStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
              return TextField(
                style: _cardSubText,
                decoration: InputDecoration(
                  label: const Text("ID"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                  labelStyle: _cardSubText
                ),
                onChanged: _management.streams.changeSubjectId,
              );
            },
          ),
        ),
        StreamBuilder(
          stream: _management.streams.subjectIdStream, 
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
            return TextButton(
              onPressed: (snapshot.hasData)?(){print("buscarIDMateria");}:null,
              child: const Icon(Icons.search, color: Colors.white, size: 30,),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue[700], 
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _registerSubsect(BuildContext context){
    return Expanded(
      child: ListView(
        children: <Widget>[
          StreamBuilder(
            stream: _management.streams.subjectNameStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
              return TextField(
                style: _cardSubText,
                decoration: InputDecoration(
                  label: const Text("Nombre asignatura"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                onChanged: _management.streams.changeSubjectName,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Color de la materia",
                style: _text,
              ),
              TextButton(
                child: const Text(""),
                style: _colorButton,
                onPressed: (){
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context){
                      return _colorPicker();
                    }
                  );
                } ,
              ),
            ],
          ),
          _expandableTeacher(),
          _expandableSchedule(),
        ],
      ),
    );
  }

  Widget _colorPicker(){
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      title: const Text("Elije un color"),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: _color, //default color
          onColorChanged: (Color color){ //on color picked
              setState(() {
                _color = color;
              });
          }, 
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Guardar"),
          onPressed: () {
            Navigator.of(context).pop(); //dismiss the color picker
          },
        ),
      ],
    );
  }

  Widget _expandableTeacher(){

    Container expandable = Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: _management.streams.subjectNameStream, 
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
                    return TextField(
                      style: _cardSubText,
                      decoration: InputDecoration(
                        label: const Text("ID del docente"), 
                        errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                      onChanged: _management.streams.changeSubjectName,
                    );
                  },
                ),
              ),
              StreamBuilder(
                stream: _management.streams.subjectIdStream, 
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
                  return TextButton(
                    onPressed: (snapshot.hasData)?(){print("ID docente");}:null,
                    child: const Icon(Icons.search, color: Colors.white, size: 30,),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[700], 
                    ),
                  );
                },
              ),
            ],
          ),
          Text(
            "Nombre:",
            style: _cardSubText
          ),
          Text(
            "Correo:",
            style: _cardSubText
          ),
          Text(
            "Celular:",
            style: _cardSubText
          )
        ],
      ),
    );

    return Card(
      child: ExpandablePanel(
        header: Text(
          "Docente",
          style: _cardText
        ),
        collapsed: Text(
          "NO asignado",
          style: _cardSubText
        ),
        expanded: expandable
      ),
    );
  }

  Widget _expandableSchedule(){

    Container expandable = Container();

    return Card(
      child: ExpandablePanel(
        header: Text(
          "Horario",
          style: _cardText
        ),
        collapsed: Text(
          "NO asignado",
          style: _cardSubText
        ),
        expanded: expandable
      ),
    );
  }

  Widget _sendRegister(){
    return StreamBuilder(
      stream: _management.streams.buttonRegisterStream, 
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {  
        return TextButton(
          onPressed: (snapshot.hasData)?(){print("Registrar materia");}:null,
          child: const Text("Registrar Materia",),
          style: _sendButton,
        );
      },
    );
  }
}
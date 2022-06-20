import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CreateSubject extends StatefulWidget {
  const CreateSubject({Key? key}) : super(key: key);

  static const String route = "CreateSubject";

  @override
  State<CreateSubject> createState() => _CreateSubjectState();
}

class _CreateSubjectState extends State<CreateSubject> {

  late TextStyle _appBarTitlle;
  late TextStyle _subTitlle;
  late TextStyle _text;
  late Management _management;
  late Color _color;

  @override
  void initState() {
    _color = Colors.deepPurple;
  }
  
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "Agenda Digital",
          style: _appBarTitlle
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.settings),
              iconSize: 30,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        )
      ),
      drawer: const Menu(),
      bottomNavigationBar: const BottomBarMenu(),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
            _registerSubsect(context)
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
            stream: _management.subjectIdStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
              return TextField(
                decoration: InputDecoration(
                  label: const Text("ID"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                  // icon: Icon(Icons.code, color: Colors.blue[700],),//icono de la izquierda
                  counterText: snapshot.data,
                ),
                onChanged: _management.changeSubjectId,
              );
            },
          ),
        ),
        StreamBuilder(
          stream: _management.subjectIdStream, 
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
            return TextButton(
              onPressed: (snapshot.hasData)?(){}:null,
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
            stream: _management.subjectIdStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
              return TextField(
                decoration: InputDecoration(
                  label: const Text("Nombre asignatura"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                  // icon: Icon(Icons.code, color: Colors.blue[700],),//icono de la izquierda
                  counterText: snapshot.data,
                ),
                onChanged: _management.changeSubjectId,
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
                style: TextButton.styleFrom(
                  backgroundColor: _color, 
                  minimumSize: const Size(60, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
                  maximumSize: const Size(60, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
                  shape: StadiumBorder()
                ),
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
          )
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
}
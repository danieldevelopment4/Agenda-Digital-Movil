// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class CreateMatterPage extends StatefulWidget {
  const CreateMatterPage({Key? key}) : super(key: key);

  static const String route = "CreateMatter";

  @override
  State<CreateMatterPage> createState() => _CreateMatterPageState();
}

class _CreateMatterPageState extends State<CreateMatterPage> {

  late Size _size;
  late Management _management;

  late TextStyle _notificationTitle;
  late TextStyle _notificationText;
  late TextStyle _subTitlle;
  late TextStyle _cardText;
  late TextStyle _cardSubText;
  late ButtonStyle _sendButton;

  // late Color _color;
  bool _searchMatterLoading = false;
  bool _createMatterLoading = false;
  bool _searchTeacherLoading = false;
  bool _teacherIdConfirmed = false;

  String _teacherId="";
  String _teacherFullName="";
  String _teacherEmail="";
  String _teacherCellphone="";

  final TextEditingController _idTextField = TextEditingController();
  final TextEditingController _nameTextField = TextEditingController();
  final TextEditingController _teacherIdTextField = TextEditingController();
  final ExpandableController _teacherExpandable = ExpandableController();
  
  @override
  Widget build(BuildContext context) {
    
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
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
    _cardText = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    _cardSubText = const TextStyle(
      fontSize: 18,
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
      drawer: const Menu(),
      bottomNavigationBar: const BottomBarMenu(),
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
            _registerMatter(context),
            _sendRegister(context),
            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  Widget _loading(){
    return const CircularProgressIndicator(
      color: Colors.white,
      strokeWidth: 4,
    );
  }

  Widget _search(){
    return Row(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
            stream: _management.streams.matterIdStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
              return TextField(
                controller: _idTextField,
                keyboardType: TextInputType.number,
                style: _cardSubText,
                decoration: InputDecoration(
                  label: const Text("ID"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                  labelStyle: _cardSubText
                ),
                onChanged: _management.streams.changeMatterId,
              );
            },
          ),
        ),
        StreamBuilder(
          stream: _management.streams.matterIdStream, 
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
            return TextButton(
              onPressed: (snapshot.hasData)?(){_serachMatterRequest();}:null,
              child: (_searchMatterLoading)?_loading():const Icon(Icons.search, color: Colors.white, size: 30,),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue[700], 
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _registerMatter(BuildContext context){
    return Expanded(
      child: ListView(
        children: <Widget>[
          StreamBuilder(
            stream: _management.streams.matterNameStream, 
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
              return TextField(
                controller: _nameTextField,
                style: _cardSubText,
                decoration: InputDecoration(
                  label: const Text("Nombre asignatura"), 
                  errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                onChanged: _management.streams.changeMatterName,
              );
            },
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: <Widget>[
          //     Text(
          //       "Color de la materia",
          //       style: _text,
          //     ),
          //     TextButton(
          //       child: const Text(""),
          //       style: _colorButton,
          //       onPressed: (){
          //         showDialog(
          //           context: context,
          //           barrierDismissible: false,
          //           builder: (context){
          //             return _colorPicker();
          //           }
          //         );
          //       } ,
          //     ),
          //   ],
          // ),
          _expandableTeacher(),
          // _expandableSchedule(),
        ],
      ),
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
                  stream: _management.streams.teacherIdStream, 
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
                    return TextField(
                      controller: _teacherIdTextField,
                      keyboardType: TextInputType.number,
                      style: _cardSubText,
                      decoration: InputDecoration(
                        label: const Text("ID del docente"), 
                        errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                      onChanged: _management.streams.changeTeacherId,
                    );
                  },
                ),
              ),
              StreamBuilder(
                stream: _management.streams.teacherIdStream, 
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) { 
                  return TextButton(
                    onPressed: (snapshot.hasData)?(){_serachTeacherRequest();}:null,
                    child: (_searchTeacherLoading)?_loading():const Icon(Icons.search, color: Colors.white, size: 30,),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[700], 
                    ),
                  );
                },
              ),
            ],
          ),
          Text(
            "Nombre: "+_teacherFullName,
            style: _cardSubText
          ),
          Text(
            "Correo: "+_teacherEmail,
            style: _cardSubText
          ),
          Text(
            "Celular: "+_teacherCellphone,
            style: _cardSubText
          ),
          TextButton(
            onPressed: (_teacherId!="")?(){
              _teacherIdConfirmed=true;
              _teacherExpandable.value = false;
              setState((){});
            }:null,
            child: const Text("Confirmar seleccion"),
            style: TextButton.styleFrom(
              primary: Colors.white, //color de la letra
              onSurface: Colors.white, //color de la letra cuando el boton esta DESACTIVADO
              backgroundColor: Colors.blue[700],
              minimumSize: Size(_size.width * .55, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
              maximumSize: Size(_size.width * .55, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
              textStyle: const TextStyle(
                fontSize: 18,
              ),
            )
          )
        ],
      ),
    );

    return Card(
      child: ExpandablePanel(
        controller: _teacherExpandable,
        header: Text(
          "Docente",
          style: _cardText
        ),
        collapsed: Text(
          (_teacherIdConfirmed)?_teacherFullName:"NO asignado",
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

  Widget _sendRegister(BuildContext context){
    return StreamBuilder(
      stream: _management.streams.matterNameStream, 
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
        return TextButton(
          onPressed: (snapshot.hasData)?(){_createMatterRequest(context);}:null,
          child: (_createMatterLoading)?_loading():const Text("Registrar Materia",),
          style: _sendButton,
        );
      },
    );
  }

  void _createMatterRequest(BuildContext context)async{
    setState(() {
      _createMatterLoading=true;
    });
    Map<String, dynamic> response = await _management.createMatterRequest(((_teacherIdConfirmed)?_teacherId:null));
    setState(() {
      _management.streams.resetMatterName();
      _nameTextField.text="";
      _createMatterLoading=false;
    });
    _notificateRequest(response);
  }

  void _serachMatterRequest()async{
    setState(() {
      _searchMatterLoading=true;
    });
    Map<String, dynamic> response = await _management.searchMatterRequest();
    setState(() {
      _management.streams.resetMatterId();
      _idTextField.text="";
      _searchMatterLoading=false;
    });
    _notificateRequest(response);
  }

  void _serachTeacherRequest()async{
    setState(() {
      _searchTeacherLoading=true;
    });
    Map<String, dynamic> response = await _management.searchTeacherRequest();
    setState(() {
      _management.streams.resetMatterId();
      _teacherIdTextField.text="";
      _searchTeacherLoading=false;
    });
    if (response["status"]) {
      _teacherIdConfirmed = false;
      _teacherId = response["body"]["id"].toString();
      _teacherFullName = response["body"]["name"]+" "+response["body"]["lastName"];
      _teacherEmail = response["body"]["email"];
      _teacherCellphone = (response["body"]["cellphone"]==null)?"NO asignado":response["body"]["email"];
    }else{
      _notificateRequest(response);
    }
  }

  void _notificateRequest(Map<String, dynamic> response){
    if (response["status"]) {
      _management.viewSubscripciptionsRequest();
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

}
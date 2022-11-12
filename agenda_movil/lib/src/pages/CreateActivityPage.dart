// ignore_for_file: file_names

import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';

import '../Logic/Management.dart';
import '../Logic/Provider.dart';
import '../Widget/Menu.dart';

class CreateActivityPage extends StatefulWidget {
  const CreateActivityPage({Key? key}) : super(key: key);

  static const String route = "CreateActivity";

  @override
  State<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {

  late Size _size;
  late Management _management;

  late TextStyle _appBarTitlle;
  late TextStyle _notificationTitle;
  late TextStyle _notificationText;
  late ButtonStyle _sendButton;

  final TextEditingController _nameTextField = TextEditingController();
  final TextEditingController _descriptionTextField = TextEditingController();
  final TextEditingController _percentTextField = TextEditingController();
  final TextEditingController _noDaysRecordatoriesTextField = TextEditingController();
  final TextEditingController _submitionDateTextField = TextEditingController();
  final TextEditingController _termTextField = TextEditingController();

  bool _createActivityLoading = false;

 @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size; //dimeiones de la pantalla
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
          style: _appBarTitlle
        ),
      ),
      drawer: const Menu(),
      bottomNavigationBar: BottomBarMenu(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            Expanded(child: _body(context)),
            _sendRegister(context),
            const SizedBox(height: 10,)
          ],
        ),
      ),
      
    );
  }

  Widget _body(BuildContext context){
    return ListView(
      children: <Widget>[
        StreamBuilder(//Nombre
          stream: _management.streams.activityNameStream,
          builder:
              (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: _nameTextField,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Taller",
                label: const Text("Nombre de la actividad"),
                errorText: (snapshot.error.toString() != "null")? snapshot.error.toString(): null,
                errorStyle: const TextStyle(color: Colors.red),
                icon: Icon(
                  Icons.short_text,
                  color: Colors.blue[700],
                ), //icono de la izquierda
              ),
              onChanged: _management.streams.changeActivityName,
            );
          },
        ),
        const SizedBox(height: 12),
        StreamBuilder(//Descripcion
          stream: _management.streams.activityDescriptionStream,
          builder:
              (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: _descriptionTextField,
              keyboardType: TextInputType.name,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Pag. 41-45",
                label: const Text("Descripcion de la actividad"),
                errorText: (snapshot.error.toString() != "null")? snapshot.error.toString(): null,
                errorStyle: const TextStyle(color: Colors.red),
                icon: Icon(
                  Icons.wrap_text,
                  color: Colors.blue[700],
                ), //icono de la izquierda
              ),
              onChanged: _management.streams.changeActivityDescription,
            );
          },
        ),
        const SizedBox(height: 12),
        StreamBuilder(//Porcentaje
          stream: _management.streams.activityPercentStream,
          builder:
              (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: _percentTextField,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "25",
                label: const Text("Porcentaje de la actividad"),
                errorText: (snapshot.error.toString() != "null")? snapshot.error.toString(): null,
                errorStyle: const TextStyle(color: Colors.red),
                icon: Icon(
                  Icons.percent,
                  color: Colors.blue[700],
                ), //icono de la izquierda
              ),
              onChanged: _management.streams.changeActivityPercent,
            );
          },
        ),
        const SizedBox(height: 12),
        StreamBuilder(//Periodo academico
          stream: _management.streams.activityTermStream,
          builder:
              (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: _termTextField,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "1",
                label: const Text("Periodo academico"),
                errorText: (snapshot.error.toString() != "null")? snapshot.error.toString(): null,
                errorStyle: const TextStyle(color: Colors.red),
                icon: Icon(
                  Icons.numbers,
                  color: Colors.blue[700],
                ), //icono de la izquierda
              ),
              onChanged: _management.streams.changeActivityTerm
            );
          },
        ),
        const SizedBox(height: 12),
        StreamBuilder(//Fecha de entrega
          stream: _management.streams.activitySubmissionDateStream,
          builder:
              (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: _submitionDateTextField,
              enableInteractiveSelection: false,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: "28/11/2022",
                label: const Text("Fecha de entrega"),
                errorText: (snapshot.error.toString() != "null")? snapshot.error.toString(): null,
                errorStyle: const TextStyle(color: Colors.red),
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.blue[700],
                ), //icono de la izquierda
              ),
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());//elimina el foco de el input
                _selectDate(context);
              },
            );
          },
        ),
        const SizedBox(height: 12),
        StreamBuilder(//No dias de recordatorio
          stream: _management.streams.activityNoDaysRecordatoriesStream,
          builder:
              (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: _noDaysRecordatoriesTextField,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: "5",
                label: const Text("No dias de recordatorio"),
                errorText: (snapshot.error.toString() != "null")? snapshot.error.toString(): null,
                errorStyle: const TextStyle(color: Colors.red),
                icon: Icon(
                  Icons.timelapse,
                  color: Colors.blue[700],
                ), //icono de la izquierda
              ),
              onChanged: _management.streams.changeActivityNoDaysRecordatories,
            );
          },
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year-1),
      lastDate: DateTime(now.year+1),
      // locale: const Locale("es", "ES")//habilitar español el calendario
    );
    if(date!=null){
      _submitionDateTextField.text = date.toString().split(' ')[0];
      _management.streams.changeActivitySubmissionDate(date.toString().split(' ')[0]);
      setState(() {});
    }
  }

  Widget _sendRegister(BuildContext context){
    return StreamBuilder(
      stream: _management.streams.buttonCreateActivityStream, 
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {  
        return TextButton(
          onPressed: (snapshot.hasData)?(){_createActivityRequest(context);}:null,
          child: (_createActivityLoading)?_loading():const Text("Registrar Actividad",),
          style: _sendButton,
        );
      },
    );
  }

  Widget _loading(){
    return const CircularProgressIndicator(
      color: Colors.white,
      strokeWidth: 4,
    );
  }

  void reset(){
    _management.streams.resetActivityName();
    _nameTextField.text="";
    _management.streams.resetActivityDescription();
    _descriptionTextField.text="";
    _management.streams.resetActivityPercentn();
    _percentTextField.text="";
    _management.streams.resetActivityNoDaysRecordatories();
    _noDaysRecordatoriesTextField.text="";
    _management.streams.resetActivitySubmissionDaten();
    _submitionDateTextField.text="";
    _management.streams.resetActivityTerm();
    _termTextField.text="";
  }

  void _createActivityRequest(BuildContext context)async{
    setState(() {
      _createActivityLoading=true;
    });
    Map<String, dynamic> response = await _management.createActivityRequest();
    setState(() {
      reset();
      _createActivityLoading=false;
    });
    _notificateRequest(response);
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
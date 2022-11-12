// ignore_for_file: file_names

import 'package:agenda_movil/src/Model/ActivityModel.dart';
import 'package:agenda_movil/src/Model/SubmitModel.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Logic/Management.dart';
import '../Logic/Provider.dart';
import '../Widget/BottomBarMenu.dart';
import '../Widget/Menu.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  static const String route = "Activity";

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late Size _size;
  late Management _management;
  
  late TextStyle _appBarTitle;
  late TextStyle _titleStile;
  late TextStyle _subtitleStile;
  late TextStyle _submitAtTimeStile;
  late TextStyle _lateSubmitStyle;
  late TextStyle _dontSubmitedStyle;
  late TextStyle _notificationTitle;
  late TextStyle _notificationText;
  late ButtonStyle _textButton;

  final TextEditingController _noteController = TextEditingController();

  late ActivityModel _activity;
  bool _edit = false;
  bool _setData = false;
  
  // "SubmitAtTime" :"Entregado a tiempo", 
  // "LateSubmit": "Entrega con retraso", 
  // "DontSubmited": "No entregado"

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    _activity = _management.getActivity();
    _appBarTitle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
    _notificationTitle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold
    );
    _notificationText = const TextStyle(
      fontSize: 15,
    );
    _titleStile = const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold
    );
    _subtitleStile = const TextStyle(
      fontSize: 20,
    );
    _submitAtTimeStile = TextStyle(
      color: Colors.green[900],
      fontSize: 20,
    );
    _lateSubmitStyle = TextStyle(
      color: Colors.amber[900],
      fontSize: 20,
    );
    _dontSubmitedStyle = TextStyle(
      color: Colors.red[900],
      fontSize: 20,
    );
    _textButton = TextButton.styleFrom(
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
          style: _appBarTitle
        ),
        
      ),
      drawer: const Menu(),
      bottomNavigationBar: BottomBarMenu(),
      body: Column(
        children: <Widget>[
          _activityData(),
          const Divider(),
          Expanded(child: _submit())
        ],
      )
    );
  }

  Widget _activityData(){
    List<Widget> column = List.empty(growable: true);
    column.add(Text(_activity.getName, style: _titleStile));
    if(_activity.getDescription!=null){
      column.add(Text(_activity.getDescription!, style: _subtitleStile));
    }
    column.add(
      Row(
        children: [
          Text(
            "Fecha de entrega: ",
            style: _subtitleStile,
          ),
          const Expanded(child: SizedBox()),
          Text(
            _activity.getSubmissionDate.split(' ')[0],
            style: _subtitleStile,
          ),
        ],
      )
    );
    column.add(
      Row(
        children: [
          Text(
            "no recordatorios: ",
            style: _subtitleStile,
          ),
          const Expanded(child: SizedBox()),
          Text(
            _activity.getNoDayRecordatories.toString(),
            style: _subtitleStile,
          ),
        ],
      )
    );
    column.add(
      Row(
        children: [
          Text(
            "Porcentaje: ",
            style: _subtitleStile,
          ),
          const Expanded(child: SizedBox()),
          Text(
            _activity.getPercen.toString(),
            style: _subtitleStile,
          ),
        ],
      )
    );
    column.add(
      Row(
        children: [
          Text(
            "Periodo academico: ",
            style: _subtitleStile,
          ),
          const Expanded(child: SizedBox()),
          Text(
            _activity.getTerm.toString(),
            style: _subtitleStile,
          ),
        ],
      )
    );
      
    return Column(
      children: column,
    );
  }

  Widget _submit(){
    String submitState = "";
    TextStyle submitStateStyle = _subtitleStile;
    List<Widget> column = List.empty(growable: true);
    if(_activity.getSumission!=null && !_edit){//tiene una entrega registrada
      column.add(
        Row(
          children: <Widget>[
            Text(
              "Nota:",
              style: _subtitleStile,
            ),
            const Expanded(child: SizedBox()),
            Text(
              _activity.getSumission!.getNote.toString(),
              style: _subtitleStile,
            ),
          ],
        )
      );
      if(_activity.getSumission!.getState=="SubmitAtTime"){
        submitState = "Entregado a tiempo";
        submitStateStyle = _submitAtTimeStile;
      }else if(_activity.getSumission!.getState=="LateSubmit"){
        submitState = "Entrega con retraso";
        submitStateStyle = _lateSubmitStyle;
      }else if(_management.streams.submitState=="DontSubmited"){
        submitState = "No entregado";
        submitStateStyle = _dontSubmitedStyle;
      }
      column.add(
        Row(
          children: <Widget>[
            Text(
              "Estado:",
              style: _subtitleStile,
            ),
            const Expanded(child: SizedBox()),
            Text(
              submitState,
              style: submitStateStyle,
            ),
          ],
        )
      );
      column.add(SizedBox(height: _size.height*.01,));
      column.add(
        TextButton(
          onPressed: () {
            _edit = true;
            _setData = true;
            setState(() {});
          },
          child: const Text("Editar"),
          style: _textButton,
        )
      );
      column.add(TextButton(
          onPressed: _deleteSubmidRequest,
          child: const Text("Eliminar"),
          style: _textButton,
        )
      );
      column.add(const Expanded(child: SizedBox(),));
    }else{
      column.add(
        StreamBuilder(
          stream: _management.streams.submitNoteStream,
          builder:
              (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: _noteController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "3.6",
                label: const Text("Nota"),
                errorText: (snapshot.error.toString() != "null")? snapshot.error.toString(): null,
                errorStyle: const TextStyle(color: Colors.red),
                icon: const Icon(
                  Icons.note_alt,
                  color: Color.fromRGBO(13, 71, 161, 1),
                ), //icono de la izquierda
              ),
              onChanged: _management.streams.changeSubmitNote,
            );
          },
        )
      );
      if(_setData){
        SubmitModel submit = _activity.getSumission!;
        _setData = false;
        _noteController.text = submit.getNote.toString();
        _management.streams.changeSubmitNote(submit.getNote.toString());
        _management.streams.changeSubmitState(submit.getState);
      }
      if(_management.streams.submitStateHasData){
        if(_management.streams.submitState=="SubmitAtTime"){
          submitState = "Entregado a tiempo";
          submitStateStyle = _submitAtTimeStile;
        }else if(_management.streams.submitState=="LateSubmit"){
          submitState = "Entrega con retraso";
          submitStateStyle = _lateSubmitStyle;
        }else if(_management.streams.submitState=="DontSubmited"){
          submitState = "No entregado";
          submitStateStyle = _dontSubmitedStyle;
        }
      }
      column.add(Row(
        children: <Widget>[
          Text(
            "Estado: ",
            style: _subtitleStile,
          ),
          const Expanded(child: SizedBox(),),
          Text(
            submitState,
            style: submitStateStyle
          ),
          TextButton(
            onPressed: (){
              showCupertinoModalPopup(
                context: context, 
                builder: buildActionSheet
              );
            }, 
            child: const Icon(Icons.edit)
          )
        ],
      ));
     column.add(const Expanded(child: SizedBox()));
      column.add(
        StreamBuilder(
          stream: _management.streams.buttonCreateSubmitStream,
          builder:
              (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return TextButton(
              onPressed: (snapshot.hasData)?(){(!_edit)?_createSubmidRequest():_editSubmidRequest();}:null, 
              child: Text((!_edit)?"Registrar entrega":"Confirmar edicion"),
              style: _textButton,
            );
          },
        )
      );
    }
    return Column(
      children: column,
    );
  }

  Widget buildActionSheet(BuildContext context){
    return CupertinoActionSheet(
      title: Text(
        "ESTADO DE ENTREGA",
        style: _subtitleStile,
      ),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: (){
            _management.streams.changeSubmitState("SubmitAtTime");
            Navigator.pop(context);
            setState(() {});
          }, 
          child: Text(
            "Entregado a tiempo",
            style: _submitAtTimeStile,
          )
        ),
        CupertinoActionSheetAction(
          onPressed: (){
            _management.streams.changeSubmitState("LateSubmit");
            Navigator.pop(context);
            setState(() {});
          }, 
          child: Text(
            "Entrega con retraso",
            style: _lateSubmitStyle,
          )
        ),
        CupertinoActionSheetAction(
          onPressed: (){
            _management.streams.changeSubmitState("DontSubmited");
            Navigator.pop(context);
            setState(() {});
          }, 
          child: Text(
            "No entregado",
            style: _dontSubmitedStyle,
          )
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: (){
          Navigator.pop(context);
        }, 
        child: const Text("Cancelar")
      ),
    );
  }

  _createSubmidRequest()async {
    Map<String, dynamic> response = await _management.createSubmitRequest();
    reset();
    _notificateRequest(response);
  }  

  _editSubmidRequest()async {
    Map<String, dynamic> response = await _management.editSubmitRequest();
    _edit=false;
    _setData=false;
    reset();
    _notificateRequest(response);
  }  

  _deleteSubmidRequest()async {
    Map<String, dynamic> response = await _management.deleteSubmitRequest();
    _notificateRequest(response);
    _activity = _management.getActivity();
  }  

  void _notificateRequest(Map<String, dynamic> response)async{
    if (response["status"]) {
      await _management.viewSubscripciptionsRequest();
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

  void reset(){
    _management.streams.resetSubmitState();
    _noteController.text = "";
    _management.streams.resetSubmitNote();
  }

}
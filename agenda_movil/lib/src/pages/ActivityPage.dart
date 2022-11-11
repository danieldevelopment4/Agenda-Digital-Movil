// ignore_for_file: file_names

import 'package:agenda_movil/src/Model/ActivityModel.dart';
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
  late ButtonStyle _textButton;

  late ActivityModel _activity;

  final Map<String, String> states = {
    "EntregaTiempo" :"Entregado a tiempo", 
    "EntregaRetraso": "Entrega con retraso", 
    "NoEntregado": "No entregado"
  };

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    _activity = _management.getActivity();
    _appBarTitle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
    _titleStile = const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold
    );
    _subtitleStile = const TextStyle(
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
      drawer: Menu(),
      bottomNavigationBar: BottomBarMenu(),
      body: Column(
        children: <Widget>[
          _activityData(),
          const Divider(),
          _submit()
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
    List<Widget> column = List.empty(growable: true);
    if(_activity.getSumission!=null){//tiene una entrega registrada
      column.add(const Expanded(child: SizedBox(),));

      column.add(
        Row(
          children: <Widget>[
            const Text("Nota:"),
            const Expanded(child: SizedBox()),
            Text(_activity.getSumission!.getNote.toString()),
          ],
        )
      );
      column.add(
        Row(
          children: <Widget>[
            const Text("Estado:"),
            const Expanded(child: SizedBox()),
            Text(_activity.getSumission!.getState),
          ],
        )
      );
      column.add(const Expanded(child: SizedBox(),));
    }else{
      // column.add(const Expanded(child: SizedBox(),));
      column.add(
        StreamBuilder(
          stream: _management.streams.submitNoteStream,
          builder:
              (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
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
      // column.add(
      //   StreamBuilder(
      //     stream: _management.streams.submitStateStream,
      //     builder:
      //         (BuildContext context, AsyncSnapshot<String> snapshot) {
      //       return TextField(
      //         keyboardType: TextInputType.number,
      //         decoration: InputDecoration(
      //           hintText: "Entrega tardia",
      //           label: const Text("Estado de entrega"),
      //           errorText: (snapshot.error.toString() != "null")? snapshot.error.toString(): null,
      //           errorStyle: const TextStyle(color: Colors.red),
      //           icon: const Icon(
      //             Icons.check_box_outlined,
      //             color: Color.fromRGBO(13, 71, 161, 1),
      //           ), //icono de la izquierda
      //         ),
      //         onChanged: _management.streams.changeSubmitState,
      //       );
      //     },
      //   )
      // );
      column.add(Text("Estado: "));
      if(_management.streams.submitStateHasData){
        column.add(Text(_management.streams.submitState));
      }
      column.add(TextButton(
        onPressed: (){}, 
        child: Text("Seleccioanr estado")
        )
      );
      column.add(
        StreamBuilder(
          stream: _management.streams.buttonCreateSubmitStream,
          builder:
              (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return TextButton(
              onPressed: (snapshot.hasData)?(){}:null, 
              child: const Text("Registrar entrega"),
              style: _textButton,
            );
          },
        )
      );
      
      // column.add(const Expanded(child: SizedBox(),));
    }
    return Column(
      children: column,
    );
  }

}
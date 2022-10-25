// ignore_for_file: file_names

import 'package:agenda_movil/src/Model/ActivityModel.dart';
import 'package:agenda_movil/src/Model/MatterModel.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:agenda_movil/src/pages/CreateActivityPage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Logic/Management.dart';
import '../Logic/Provider.dart';

class MatterPage extends StatelessWidget {
  MatterPage({Key? key}) : super(key: key);

  static const String route = "Subject";

  late Size _size;
  late Management _management;
  
  late TextStyle _titlle;
  late TextStyle _headerSubTitlle;
  late TextStyle _headerSubTitlleApproved;
  late TextStyle _headerSubTitlleDeprecated;
  late TextStyle _cardTitlle;
  late TextStyle _cardTitlleApproved;
  late TextStyle _cardTitlleDeprecated;
  late TextStyle _cardSubTitlle;

  TextEditingController searchTextField = TextEditingController();

  late MatterModel _matter;
  late List<ActivityModel> _activitiesList;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
     _matter = _management.getMatter();
     _activitiesList = _matter.getActivitiesList;
    _titlle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
    _headerSubTitlle = const TextStyle(
      fontSize: 20,
    );
    _headerSubTitlleApproved = const TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    );
    _headerSubTitlleDeprecated = const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    );
    _cardTitlle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
    _cardTitlleApproved = const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.green,
      fontSize: 18,
    );
    _cardTitlleDeprecated = const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.red,
      fontSize: 18,
    );
    _cardSubTitlle = const TextStyle(
      color: Colors.grey,
      fontSize: 15,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "Agenda Digital",
          style: _titlle
        ),
        
      ),
      drawer: Menu(),
      bottomNavigationBar: BottomBarMenu(),
      body: Column(
        children: <Widget>[
          _header(),
         const Divider(),
         Expanded(
           child: PageView(
            children: <Widget>[
              _activitys(context),
              _teacher(),
            ],
           ),
         )
        ],
      ),
    );
  }

  Widget _header(){

    int percent = 0;
    double note = 0;
    
    if (_activitiesList.isNotEmpty) {
      int term = _activitiesList[_activitiesList.length-1].getTerm;
      for (var i = _activitiesList.length-1; i >= 0; i--) {
        if(term==_activitiesList[i].getTerm){
          percent+=_activitiesList[i].getPercen;
          if(_activitiesList[i].getSumission!=null){
            if (_activitiesList[i].getSumission!.getNote!=null) {
              note += _activitiesList[i].getSumission!.getNote!*_activitiesList[i].getPercen;
            }
          }
        }else{
          break;
        }
      }
    }
    return Column(
          children: <Widget>[
            const SizedBox(width: double.infinity),
            Text(
              _matter.getName,
              style: _titlle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Definitiva actual: ",
                  style: _headerSubTitlle,
                ),
                Text(
                  note.toString(),
                  style: (note>=3)?_headerSubTitlleApproved:_headerSubTitlleDeprecated,
                ),
              ],
            ),
            LinearPercentIndicator(
              width: _size.width*.95,
              animation: true,
              animationDuration: 1200,
              lineHeight: 20.0,
              percent: percent/100,
              center: Text(
                percent.toString(),
                style: _headerSubTitlle,
              ),
              progressColor: Colors.green[300],
            ),
          ],
    );
  }

  Widget _activitys(BuildContext context){
    List<Widget>  activities = List.empty(growable: true); 
    
    for(int i=0; i<_activitiesList.length; i++){
      activities.add(_card(_activitiesList[i], i));
    }
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "ACTIVIDADES",
                    style: _headerSubTitlle
                  ), 
                  const Expanded(child: SizedBox()),
                  IconButton(icon: const Icon(Icons.add), iconSize: 30, color: Colors.blue[700], onPressed: (){
                      Navigator.pushNamed(context, CreateActivityPage.route);
                    }
                  ),
                  
                ],
              ),
              TextField(
                controller: searchTextField,
                decoration: InputDecoration(
                  hintText: "Filtrar",
                  prefix: Icon(Icons.search_rounded, color: Colors.blue[700]!),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue[700]!)
                  )

                ), 
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: activities,
          ),
        ),
      ],
    );
  }

  Widget _card(ActivityModel activity, int matterIndex){
    TextStyle titleStile = const TextStyle(
      fontSize: 20,
    );
    TextStyle subtitleStile = const TextStyle(
      fontSize: 13,
      color: Colors.grey
    );
    List<Widget> column = List.empty(growable: true);
    List<Widget> row = List.empty(growable: true);
    List<Widget> row1 = List.empty(growable: true);
    Color color = Colors.grey;

    row.add(Text(activity.getName, style: titleStile,));
    row.add(const Expanded(child: SizedBox()));
    if(activity.getSumission!=null){
      if(activity.getSumission!.getNote!=null){
        if(activity.getSumission!.getNote!>=3){
          color = Colors.green;
        }else{
          color = Colors.deepOrange;
        }
        row.add(Text(
          activity.getSumission!.getNote!.toString(),
          style: TextStyle(
            fontSize: 13,
            color: color
          ),
        ));
        row.add(const Icon(Icons.rate_review));
      }
    }
    column.add(ListTile(title: Row(children: row,)));
    column.add(Text(
      (activity.getDescription!=null)?activity.getDescription!:"",
      style: subtitleStile,
    ));
    column.add(Divider(color: color, height: 2.8,));
    row1.add(Text(activity.getSubmissionDate, style: subtitleStile,));
    row1.add(const Icon(Icons.calendar_month, color: Colors.grey,));
    row1.add(const Expanded(child: SizedBox()));
    row1.add(Text(activity.getNoDayRecordatories.toString(), style: subtitleStile,));
    row1.add(const Icon(Icons.timelapse, color: Colors.grey,));
    row1.add(const Expanded(child: SizedBox()));
    row1.add(Text(activity.getPercen.toString(), style: subtitleStile,));
    row1.add(const Icon(Icons.percent, color: Colors.grey,));
    column.add(ListTile(title: Row(children: row1,)));

    return GestureDetector(
      onTap: () {
        print("Activity:"+activity.getId.toString()+"::"+activity.getName);
        _management.setMatterIndex=matterIndex;
        _management.setIndex=-1;
        // Navigator.pushReplacementNamed(context, MatterPage.route);
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        child: Card(
          elevation: 10,//sombreado
          shape: RoundedRectangleBorder(
            side: BorderSide(color: color),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Container(
            padding: const EdgeInsets.all(7),
            child: Column(
              children: column,
            ),
          ),
        ),
      ),
    );
  }


  Widget _teacher(){
    return Column(
      children: <Widget>[
        Text(
          "DOCENTE",
          style: _headerSubTitlle
        ),
        Expanded(child: ListView()),
      ],
    );
  }

}
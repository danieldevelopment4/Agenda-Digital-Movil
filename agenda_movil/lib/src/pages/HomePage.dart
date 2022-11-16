// ignore_for_file: constant_identifier_names

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Model/ActivityModel.dart';
import 'package:agenda_movil/src/Model/MatterModel.dart';
import 'package:agenda_movil/src/Model/SubscriptionModel.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Calendar.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:agenda_movil/src/pages/MatterPage.dart';
import 'package:agenda_movil/src/pages/TutorialPage.dart';
import 'package:flutter/material.dart';

import 'CreateMatterPage.dart';

class HomePage extends StatefulWidget {

  HomePage(int route, {Key? key}) : super(key: key){
    _route = route;
  }

  late final int _route;
  static const String TableRoute = "TableRoute";
  static const String HomeRoute = "HomeRoute";
  static const String CalendarRoute = "CalendarRoute";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  late Size _size;
  late Management _management;

  late TextStyle _appBar;
  late TextStyle _emojiText;
  late TextStyle _dataText;
  late TextStyle _headerSubTitlle;
  late ButtonStyle _buttonText;

  late PageController _pageController;

  late List<SubscriptionModel> _subscriptionList;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget._route);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    _subscriptionList = _management.getSubscriptionList;
    _appBar = const TextStyle(
      fontSize: 30,
    );
    _headerSubTitlle = const TextStyle(
      fontSize: 20,
    );
    _buttonText = TextButton.styleFrom(
      primary: Colors.white, //color de la letra
      onSurface: Colors.white, //color de la letra cuando el boton esta DESACTIVADO
      backgroundColor: Colors.blue[700],
      minimumSize: Size(_size.width * .4, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      maximumSize: Size(_size.width * .4, 40), //tamaño minimo deo boton, con esto todos quedaran iguales
      textStyle: const TextStyle(
        fontSize: 18,
      ),
    );
    _emojiText = TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.blue[700],
    );
    _dataText = const TextStyle(
      fontSize: 20,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "Agenda Digital",
          style: _appBar
        ),
      ),
      drawer: const Menu(),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _notes(),
          _matters(),
          _calendar()
        ],
        onPageChanged: (int value){
          _management.setIndex=value;
          setState(() {});
        },
      ),
      bottomNavigationBar:  BottomBarMenu(),
      
    );
  }

  Widget _headerContainer(String text, Color color){
    return Container(
      // height: height,
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(3, 169, 244, .7),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color
          ),
          textAlign: TextAlign.center,
        )
      ),
    );
  }

  Widget _rowContainer(String text, Color color){
    return Container(
      // height: height,
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(33, 150, 243, .3),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: color
          ),
          textAlign: TextAlign.center,
        )
      ),
    );
  }

  Widget _notes(){ 
    
    List<TableRow> rows = List.empty(growable: true);
    rows.add(TableRow(
        children: <Widget>[
          _headerContainer("Materia", Colors.black),
          _headerContainer("%", Colors.black),
          _headerContainer("Nota", Colors.black),
        ]
      )
    );
    for (int i = 0; i < _subscriptionList.length; i++) {
      int percent = 0;

      double note = 0;
      MatterModel matter = _subscriptionList[i].getMatter;
      if(!_subscriptionList[i].getRequest){
        List<ActivityModel> activitiesList = matter.getActivitiesList;
        if (activitiesList.isNotEmpty) {
          int term = activitiesList[activitiesList.length-1].getTerm;
          for (var i = activitiesList.length-1; i >= 0; i--) {
            if(term==activitiesList[i].getTerm){
              percent+=activitiesList[i].getPercen;
              if(activitiesList[i].getSumission!=null){
                if (activitiesList[i].getSumission!.getNote!=null) {
                  note += activitiesList[i].getSumission!.getNote!*activitiesList[i].getPercen/100;
                }
              }
            }else{
              break;
            }
          }
        }
      }
      rows.add(TableRow(
          children: <Widget>[
            _rowContainer(matter.getName, Colors.black),
            _rowContainer(percent.toString(), Colors.black),
            _rowContainer(note.toStringAsFixed(2), (note<3)?Colors.deepOrange:Colors.green[700]!),
          ]
        )
      );
    }


    return ListView(
      children: <Widget>[
        Table(
          columnWidths: const {
            0: FlexColumnWidth(70),
            1: FlexColumnWidth(15),
            2: FlexColumnWidth(15)
          },
          children: rows,
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
        )
      ],
    );
  }

  Widget _withOutMatters(){
    return Column(
      children: <Widget>[
        SizedBox(height: _size.height*.1,),
        Text(
          "(⊙_⊙)？",
          textAlign: TextAlign.center,
          style: _emojiText
        ),
        const SizedBox( height: 25,),
        Text(
          "Parece que aun no tienes materias pero no te preocupes",
          textAlign: TextAlign.center,
          style: _dataText
        ),
        TextButton(
          onPressed: () => {
            Navigator.pushNamed(context, CreateMatterPage.route),
            _management.setIndex = -1
          },
          child: const Text("Agregar materia"),
          style: _buttonText,
        ),
         SizedBox(height: _size.height*.13,),
         Text(
          "O puedes revisar el tutorial que hicimos preparado para ti",
          textAlign: TextAlign.center,
          style: _dataText
        ),
        TextButton(
          onPressed: () => {
            Navigator.pushNamed(context, TutorialPage.route),
            _management.setIndex = -1
          },
          child: const Text("Ver tutorial"),
          style: _buttonText,
        ),
        // const Expanded(child: SizedBox()),
      ],
    );
  }

  Widget _matters(){
    List<Widget> matters = List.empty(growable: true);
    matters.add(
      Container(
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Row(
          children: <Widget>[
            Text(
              "MATERIAS",
              style: _headerSubTitlle
            ), 
            const Expanded(child: SizedBox()),
            IconButton(icon: const Icon(Icons.add), iconSize: 30, color: Colors.blue[700], onPressed: (){
                _management.setIndex=-1;
                Navigator.pushNamed(context, CreateMatterPage.route);
              }
            ),
            
          ],
        ),
      ),
    );
    if(_subscriptionList.isNotEmpty){
      List<Widget>  mattersList = List.empty(growable: true); 
      for(int i=0; i<_subscriptionList.length; i++){
        mattersList.add(_card(_subscriptionList[i], i));
      }
      matters.add(Expanded(
          child: ListView(
            children: mattersList
          ),
        )
      );
    }else{
      matters.add(_withOutMatters());
    }
    return Column(
      children: matters,
    );
  }

  Widget _calendar(){
    return ListView(
      children: [
        Container(
          // decoration: BoxDecoration(color: Colors.red),
          height: _size.height*.5,
          margin:  const EdgeInsets.all(10),
          child: const Calendar()
        ),
        // const SizedBox(height:10, width: double.infinity,),
        Container(
          width: _size.width*.85,
          margin:  const EdgeInsets.all(10),
          padding: const EdgeInsets.all(25),
          height: _size.height*.25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.blue[700]!,
                blurRadius: 20,//nivel de difuminado
                offset: const Offset(0, 5),//posicion
                spreadRadius: 1//agrandar la caja
              )
            ]
          ),
        )
      ],
    );
  }

  Widget _card(SubscriptionModel subscription, int matterIndex){
    MatterModel matter = subscription.getMatter;
    TextStyle titleStile = const TextStyle(
      fontSize: 20,
    );
    TextStyle warningStile = const TextStyle(
      color: Colors.red,
      fontSize: 20,
    );
    String teacher = ((matter.getTeacher==null)?"Docente no asignado":"Docente: "+matter.getTeacher!.getFullName);
    List<Widget> column = List.empty(growable: true);
    List<Widget> row = List.empty(growable: true);
    row.add(Text(matter.getName, style: titleStile,));
    if(subscription.request){
      List<Widget> waiting = List.empty(growable: true);
      waiting.add(Text("Estamos a la \nespera del admin", style: warningStile, textAlign: TextAlign.center,));
      row.add(const Expanded(child: SizedBox()));
      row.add(Column(children: waiting,));
    }else{
      row.add(const Expanded(child: SizedBox()));
      row.add(Text(matter.getStucentsCount.toString(), style: const TextStyle(color: Colors.grey),));
      row.add(const Icon(Icons.person));
      column.add(const Divider(color: Colors.blue, height: 2.8,));
      column.add(Text(teacher));
    }
    column.insert(0, ListTile(title: Row(children: row,),));
    

    return GestureDetector(
      onTap: (!subscription.getRequest)?() {
        _management.setMatterIndex=matterIndex;
        _management.setIndex=-1;
        Navigator.pushNamed(context, MatterPage.route);
      }:(){},
      child: Container(
        margin: const EdgeInsets.all(7),
        child: Card(
          elevation: 10,//sombreado
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(12)),
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
}
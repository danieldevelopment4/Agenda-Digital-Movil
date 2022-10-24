// ignore_for_file: constant_identifier_names

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Model/MatterModel.dart';
import 'package:agenda_movil/src/Model/SubscriptionModel.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Calendar.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:agenda_movil/src/pages/MatterPage.dart';
import 'package:flutter/material.dart';

import '../Persistence/Percistence.dart';
import 'CreateMatterPage.dart';

class HomePage extends StatefulWidget {

  HomePage(int route, {Key? key}) : super(key: key){
    _route = route;
  }

  late final int _route;
  static const String HomeRoute = "HomeRoute";
  static const String CalendarRoute = "CalendarRoute";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late TextStyle _appBar;
  late TextStyle _emojiText;
  late TextStyle _dataText;
  late ButtonStyle _buttonText;
  late Management _management;
  late Size _size;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget._route);
    
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);
    // _management.setSubscriptionList();
    _appBar = const TextStyle(
      fontSize: 30,
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
      drawer: Menu(),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
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

  Widget _withOutMatters(){
    return Column(
      children: <Widget>[
        const Expanded(child: SizedBox()),
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
            Navigator.pushReplacementNamed(context, CreateMatterPage.route),
            _management.setIndex = -1
          },
          child: const Text("Agregar materia"),
          style: _buttonText,
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  Widget _matters(){
    List<SubscriptionModel> subscriptionList = _management.getSubscriptionList;
    
    if(subscriptionList.isNotEmpty){
      List<Widget>  mattersList = List.empty(growable: true); 
      for(int i=0; i<subscriptionList.length; i++){
        mattersList.add(_card(subscriptionList[i]));
      }
      return ListView(
        children: mattersList
      );
    }else{
      return _withOutMatters();
    }
    
  }


  Widget _card(SubscriptionModel subscription){
    MatterModel matter = subscription.getMatter;
    List<String> rgb = matter.getRgb.split(',') ;
    Color shadow = Color.fromRGBO(int.parse(rgb[0]), int.parse(rgb[1]), int.parse(rgb[2]), 1);
    TextStyle titleStile = const TextStyle(
      fontSize: 20,
    );
    TextStyle warningEmojiStile = const TextStyle(
      color: Colors.red,
      fontSize: 20,
    );
    String teacher = ((matter.getTeacher==null)?"Docente no asignado":"Docente: "+matter.getTeacher!.getFullName);
    List<Widget> column = List.empty(growable: true);
    List<Widget> row = List.empty(growable: true);
    row.add(Text(matter.getName, style: titleStile,));
    if(subscription.request){
      List<Widget> waiting = List.empty(growable: true);
      waiting.add(Text("(*^▽^*)", style: warningEmojiStile,));//(≧∇≦)ﾉ   (*^▽^*)
      waiting.add(Text("Ya casi nos\nacepta el admin", style: warningEmojiStile, textAlign: TextAlign.center,));
      row.add(const Expanded(child: SizedBox()));
      row.add(Column(children: waiting,));
    }else{
      row.add(const Expanded(child: SizedBox()));
      row.add(Text(matter.getStucentsCount.toString(), style: const TextStyle(color: Colors.grey),));
      row.add(const Icon(Icons.person));
      column.add(const Divider());
      column.add(Text(teacher));
    }
    column.insert(0, ListTile(title: Row(children: row,),));
    

    return GestureDetector(
      onTap: () {
        print("Tap:"+subscription.getId.toString()+"::"+matter.getName);
        _management.setIndex=-1;
        Navigator.pushReplacementNamed(context, MatterPage.route);
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        child: Card(
          elevation: 35,//sombreado
          shadowColor: shadow,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
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

}
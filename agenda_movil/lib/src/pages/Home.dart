import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Calendar.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:agenda_movil/src/pages/Subject.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  Home(int route, {Key? key}) : super(key: key){
    _route = route;
  }

  late final int _route;
  static const String HomeRoute = "HomeRoute";
  static const String CalendarRoute = "CalendarRoute";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late TextStyle _subTitlle;
  late Management _management;
  late Size _size;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget._route);
  }

  @override
  Widget build(BuildContext context) {
    _management = Provider.of(context);
    _subTitlle = const TextStyle(
      fontSize: 30,
    );
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "Agenda Digital",
          style: _subTitlle
        ),
      ),
      drawer: Menu(),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _subject(),
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

  Widget _subject(){
    return ListView(
      children: <Widget>[
        _card("Progra 3", "", 12, "Jahiro Armando Riaño", Colors.orange),
        _card("Competencias comunicativas", "Ensayo IOT", 25, "Maria Piñeros", Colors.deepPurple),
        _card("Calculo 4", "Correccion parcial", 12, "Alvaro Perez", Colors.red),
        _card("Ingles VI", "", 12, "No asignado", Colors.green),
        _card("BD2", "", 18, "Monica Duran", Colors.green),
        _card("Metodos Numericos", "Correccion parcial", 12, "Fredy Alarcon", Colors.brown),
        _card("Sistemas Distribuidos", "Ejercicios Edificios\nMicro Expo", 20, "Camilo Bohorques", Colors.lime),
        
      ],
    );
  }

  Widget _card(String subjectName, String activitys, int menbers, String teacher, Color color){
    return GestureDetector(
      onTap: () {
        print("Tap:"+subjectName);
        _management.setIndex=-1;
        Navigator.pushReplacementNamed(context, Subject.route);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Card(
          elevation: 15,//sombreado
          shadowColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Container(
            padding: const EdgeInsets.all(7),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Row(
                  children: <Widget>[
                    Text(subjectName),
                    const Expanded(child: SizedBox()),
                    Text(
                      menbers.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Icon(Icons.person),
                  ],
                ),
                  subtitle: Text(activitys),
                ),
                const Divider(),
                Text("Docente: "+teacher)
              ],
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
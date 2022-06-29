import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:agenda_movil/src/pages/createActivity.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Subject extends StatelessWidget {
  Subject({Key? key}) : super(key: key);

  static const String route = "Subject";

  late Size _size;
  late TextStyle _titlle;
  late TextStyle _headerSubTitlle;
  late TextStyle _headerSubTitlleApproved;
  late TextStyle _headerSubTitlleDeprecated;
  late TextStyle _cardTitlle;
  late TextStyle _cardTitlleApproved;
  late TextStyle _cardTitlleDeprecated;
  late TextStyle _cardSubTitlle;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
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
      drawer: Menu(),
      bottomNavigationBar: BottomBarMenu(),
      body: Column(
        children: <Widget>[
          _header(),
         const Divider(),
         Expanded(
           child: PageView(
            children: <Widget>[
              Column(
                children: [
                  Text(
                    "NOTAS",
                    style: _headerSubTitlle
                  ),
                  _notes(),
                ],
              ),
              Column(
                children: [
                   Text(
                    "ACTIVIDADES",
                    style: _headerSubTitlle),                  
                  _activitys(context),
                ],
              ),
              Column(
                children: [
                  Text(
                    "DOCENTE",
                    style: _headerSubTitlle),
                  _teacher(),
                ],
              ),
            ],
           ),
         )
        ],
      ),
    );
  }

  Widget _header(){
    return Column(
          children: <Widget>[
            const SizedBox(width: double.infinity),
            Text(
              "Progra 3",
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
                  "3.5",
                  style: (3.5>=3)?_headerSubTitlleApproved:_headerSubTitlleDeprecated,
                ),
              ],
            ),
            // CircularPercentIndicator(
            //   radius: 55.0,
            //   animation: true,
            //   animationDuration: 1200,
            //   lineWidth: 15.0,//grozor del progressbar
            //   percent: 0.78,
            //   center: Text(
            //     "78%",
            //     style: _headerSubTitlle,
            //   ),
            //   circularStrokeCap: CircularStrokeCap.butt,//terminacion del progressbar
            //   progressColor: Colors.blue[700],
            // ),
            LinearPercentIndicator(
              width: _size.width*.95,
              animation: true,
              animationDuration: 1200,
              lineHeight: 20.0,
              percent: 0.78,
              center: Text(
                "78%",
                style: _headerSubTitlle,
              ),
              progressColor: Colors.green[300],
            ),
          ],
    );
  }

  Widget _notes(){
    return Expanded(
      child: ListView(
        children: <Widget>[
          Table(
            children: const <TableRow>[
              TableRow(
                children: <Widget>[
                  Text("Actividad"),
                  Text("Porcentaje"),
                  Text("Nota"),
                ]
              ),
              TableRow(
                children: <Widget>[
                  Text("Taller grupal"),
                  Text("10%"),
                  Text("4.8"),
                ]
              ),
            ],
            defaultColumnWidth: const FlexColumnWidth(),
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
          )
        ],
      ),
    );
  }

  Widget _activitys(BuildContext context){
    return Expanded(
      child: ListView(
        children: <Widget>[
          _card("Proyecto", 3.5, "", "23/05/2020 23:59", 5, "20", Colors.green, context),
          _card("Taller Individual", 5, "Moodle", "23/05/2020 23:59", 5, "10", Colors.green, context),
          _card("Taller grupal", 4.9, "Moodle", "23/05/2020 23:59", 5, "10", Colors.green, context),
          _card("Parcial 1", 1.8, "", "23/05/2020 23:59", 5, "20", Colors.red, context),
          _card("Parcial 2", 2.3, "", "23/05/2020 23:59", 5, "20", Colors.red, context),
          _card("Quiz", 3.5, "C/C++", "23/05/2020 23:59", 5, "20", Colors.green, context),
        ],
      ),
    );
  }

  Widget _card(String activityName, double note, String description, String date, int remember, String percent, Color color, BuildContext context){
    return GestureDetector(
        onDoubleTap: () => Navigator.pushReplacementNamed(context, CreateActivity.route),
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
            child:Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      activityName,
                      style: _cardTitlle,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          note.toString(),
                          style: (note>=3)?_cardTitlleApproved:_cardTitlleDeprecated
                        ),
                        const Icon(Icons.rate_review),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          date.toString(),
                          style: _cardSubTitlle
                        ),
                        const Icon(Icons.calendar_month, color: Colors.grey),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          remember.toString(),
                          style: _cardSubTitlle
                        ),
                        const Icon(Icons.timelapse, color: Colors.grey),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          percent.toString(),
                          style: _cardSubTitlle
                        ),
                        const Icon(Icons.percent, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Text(
                  description,
                  style: _cardSubTitlle
                )
              ],
            ),
          ),
        ),
      ),
    );

  }


  Widget _teacher(){
    return Expanded(child: ListView());
  }

}
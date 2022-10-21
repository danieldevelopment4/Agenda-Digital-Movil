// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key? key}) : super(key: key);

  static const String route = "Rate";

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  late Size _size;
  late TextStyle _cardText;
  late TextStyle _cardSubText;
  late TextStyle _titlle;
  late TextStyle _appBarTitlle;
  late Management _management;

  String _drop = "";//opcion inicial del combobox de reporte de error
  
  final TextEditingController _tecSummary = TextEditingController();
  dynamic _errorSumarry;
  final TextEditingController _tecDescription = TextEditingController();
  dynamic _errorDescription;
  final TextEditingController _tecSuggestion = TextEditingController();
  dynamic _errorSuggestion;

  late ButtonStyle _sendButton;

  

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size; //dimeiones de la pantalla
    _management = Provider.of(context);

    _titlle = TextStyle(
      color: Colors.blue[700],
      fontSize: 30,
    );
    _appBarTitlle = const TextStyle(
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
      onSurface:
          Colors.white, //color de la letra cuando el boton esta DESACTIVADO
      backgroundColor: Colors.blue[700],
      minimumSize: Size(_size.width * .9,
          40), //tamaño minimo deo boton, con esto todos quedaran iguales
      maximumSize: Size(_size.width * .9,
          40), //tamaño minimo deo boton, con esto todos quedaran iguales
      textStyle: const TextStyle(
        fontSize: 18,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text("Agenda Digital", style: _appBarTitlle),
      ),
      drawer: Menu(),
      bottomNavigationBar: BottomBarMenu(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Text(
                  "Estamos siempre para darte lo mejor",
                  style: _titlle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "¿Como calificarias nuestro servicio?",
                  style: _cardSubText,
                ),
                _rateStars(),
              ],
            ),
            _expandableErrorReport(),
            _expandablesuggestion(),
            TextButton(
              onPressed: () {
                Map<String, String> body = {

                };
                _management.rateRequest(body);
              },
              child: const Text(
                "Enviar valoracion",
              ),
              style: _sendButton,
            )
          ],
        ),
      ),
    );
  }

  Widget _rateStars() {
    return RatingBar.builder(
      initialRating: 4,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        // print(rating);
      },
    );
  }

  Widget _expandableErrorReport() {
    Container expandable = Container(
       padding: const EdgeInsets.all(10),
       child: Column(
        children: <Widget>[
          Text(
            "¿Donde encontraste el error?",
            style: _cardSubText,
          ),
          _dropDown(),
          Text(
            "Ingresa una breve descripcion de lo que sucedio",
            style: _cardSubText,
          ),
          _summary(),
          Text(
            "Dimos que hciiste para allar el error",
            style: _cardSubText,
          ),
          _description(),
        ],
       )
    );

    return Card(
      child: ExpandablePanel(
          header: Text("Reportar un error", style: _cardText),
          collapsed: Text(
              "Si hallaste un error con todo el gusto lo solucionaremos",
              style: _cardSubText),
          expanded: expandable),
    );
  }

  Widget _dropDown(){
    return DropdownButton(
      value: _drop,//este sera el primer item a mostrar, debe de ser uno de los que se halla en la lista
      items: getOptions(),
      onChanged: (value){
         _drop = value.toString();
        setState(() {});
      },
    );
  }

  final List<String> _options = ["",
                           "Inicio de sesion / Registro",
                           "Panel de asignatura",
                           "Panel de docentes"];
                           

  List<DropdownMenuItem<String>> getOptions (){
    List<DropdownMenuItem<String>> list = List.empty(growable: true);
    for (var option in _options) {
      list.add(
        DropdownMenuItem(
          child: Text(option),
          value: option,
        )
      );
    }
    return list;
  }

  Widget _summary() {
    return TextField(
      keyboardType: TextInputType.multiline,
      controller: _tecSummary,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "fallo en...",
        label: const Text("Sugerencias"),
        errorText: _errorSumarry,
        errorStyle: const TextStyle(color: Colors.red),
        counter: Text(_tecSummary.text.length.toString() + "/120"),
      ),
      onChanged: (String value) {
        if (value.length < 120) {
          _errorSumarry = null;
          // _tecSuggestion.text = value;
        } else {
          _errorSumarry = "Has llegado al limite de caracteres permitidos";
          _tecSummary.text = value;
        }

        setState(() {});
      },
    );
  }

  Widget _description() {
    return TextField(
      keyboardType: TextInputType.multiline,
      controller: _tecDescription,
      maxLines: 8,
      decoration: InputDecoration(
        hintText: "Enumera lo que sucedió antes de que ocurriera el error:\n1)\n2)\n3)\n\nResultado esperado:\nResultado obtenido:",
        label: const Text("Recreemos lo sucedido"),
        errorText: _errorDescription,
        errorStyle: const TextStyle(color: Colors.red),
        counter: Text(_tecDescription.text.length.toString() + "/450"),
      ),
      onChanged: (String value) {
        if (value.length < 450) {
          _errorDescription = null;
          // _tecSuggestion.text = value;
        } else {
          _errorDescription = "Has llegado al limite de caracteres permitidos";
          _tecDescription.text = value;
        }

        setState(() {});
      },
    );
  }

  Widget _expandablesuggestion() {
    Container expandable = Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[_commentary()],
      ),
    );
    return Card(
      child: ExpandablePanel(
          header: Text("Sugerencia", style: _cardText),
          collapsed: Text(
              "Cuentanos tus ideas, puede que salgan en una futura actualziacion",
              style: _cardSubText),
          expanded: expandable),
    );
  }

  Widget _commentary() {
    return TextField(
      keyboardType: TextInputType.multiline,
      controller: _tecSuggestion,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "¡¡Sigan asi!!",
        label: const Text("Sugerencias"),
        errorText: _errorSuggestion,
        errorStyle: const TextStyle(color: Colors.red),
        counter: Text(_tecSuggestion.text.length.toString() + "/250"),
      ),
      onChanged: (String value) {
        if (value.length < 250) {
          _errorSuggestion = null;
          // _tecSuggestion.text = value;
        } else {
          _errorSuggestion = "Has llegado al limite de caracteres permitidos";
          _tecSuggestion.text = value;
        }

        setState(() {});
      },
    );
  }
}

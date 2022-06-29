import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/Widget/BottomBarMenu.dart';
import 'package:agenda_movil/src/Widget/Menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rate extends StatefulWidget {
  Rate({Key? key}) : super(key: key);

  static const String route = "Rate";

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {

  late Size _size;
  late TextStyle _subTitlle;
  late Management _management;
  late String _value="";
  late String _error;

  final TextEditingController _textEditingController = TextEditingController();
  late ButtonStyle _sendButton;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
    _management = Provider.of(context);

     _subTitlle = const TextStyle(
      fontSize: 30,
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
      drawer: Menu(),
      bottomNavigationBar:  BottomBarMenu(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            _rateStars(),
            const SizedBox(height: 12),
            const Text("Tu opinion es importante para nosotros, dejanos un comentario ;)"),
            _commentary(),
            _sendCommentary()
          ],
        ),
      ),
    );
  }

  Widget _rateStars(){
    return RatingBar.builder(
      initialRating: 3,
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
        print(rating);
      },
    );
  }

  Widget _commentary(){
    return StreamBuilder(
      stream: _management.emailStream, 
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
        return TextField(
          keyboardType: TextInputType.multiline,
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: "¡¡Sigan asi!!",
            label: const Text("Sugerencias"), 
            errorText: (snapshot.error.toString()!="null")?snapshot.error.toString():null,
            errorStyle: const TextStyle(color: Colors.red),
            counter: Text(_value.length.toString()),
          ),
         onChanged: (String value){
              
              if(value.length<140){
                _value = value;
              }else{
                _error="Has llegado al limite de caracteres permitidos";
                _textEditingController.text=_value;
              }
              
              setState(() {});
            },
        );
      },
    );
  }

  Widget _sendCommentary(){
    return StreamBuilder(
      stream: _management.buttonRegisterStream, 
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {  
        return TextButton(
          onPressed: (snapshot.hasData)?(){print("Enviar valoracion");}:null,
          child: const Text("Enviar valoracion",),
          style: _sendButton,
        );
      },
    );
  }

}
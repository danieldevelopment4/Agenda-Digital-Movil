// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MyColorPicker extends StatefulWidget {
  MyColorPicker({Key? key}) : super(key: key);

  final _MyColorPickerState _myColorPickerState = _MyColorPickerState();

  Color get getColor{
    return _myColorPickerState.getColor;
  }

  @override
  State<StatefulWidget> createState(){
    return _myColorPickerState;
  }
}

class _MyColorPickerState extends State<MyColorPicker> {
  Color _myColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      title: const Text("Elije un color"),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: _myColor, //default color
          onColorChanged: (Color color){ //on color picked
              setState(() {
                _myColor = color;
              });
          }, 
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Guardar"),
          onPressed: () {
            Navigator.of(context).pop(); //dismiss the color picker
          },
        ),
      ],
    );
  }

  Color get getColor{
    return _myColor;
  }
}
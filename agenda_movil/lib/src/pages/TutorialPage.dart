// ignore_for_file: file_names


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../Logic/Management.dart';
import '../Logic/Provider.dart';
import '../Widget/BottomBarMenu.dart';
import '../Widget/Menu.dart';



class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  static const String route ="Tutorial";

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {

  
  late File _file;

  late Management _management;
  
  late TextStyle _titlle;

  @override
  Widget build(BuildContext context) {
    _management = Provider.of(context);
    _file = _management.getFile;
    _titlle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text(
          "Agenda Digital",
          style: _titlle
        ),
      ),
      drawer: const Menu(),
      bottomNavigationBar: const BottomBarMenu(),
      body: PDFView(
        filePath: _file.path,
        // autoSpacing: false,
        // swipeHorizontal: true,
        // pageSnap: false,
        // pageFling: false,
      )
    );
  }

  

  
}
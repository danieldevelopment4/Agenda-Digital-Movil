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
  late PDFViewController _controller;
  int _pages = 0;
  int _indexPage = 0;

  late Size _size;
  late Management _management;
  
  late TextStyle _titlle;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;//dimeiones de la pantalla
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
        actions: _pages >= 2?[
          Center(child: Text('${_indexPage + 1} of $_pages')),
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 32),
            onPressed: () {
              final page = _indexPage == 0 ? _pages : _indexPage - 1;
              _controller.setPage(page);
            },
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 32),
            onPressed: () {
              final page = _indexPage == _pages - 1 ? 0 : _indexPage + 1;
              _controller.setPage(page);
            },
          ),
        ]: null,
      ),
      drawer: Menu(),
      bottomNavigationBar: BottomBarMenu(),
      body: PDFView(
        filePath: _file.path,
        // autoSpacing: false,
        // swipeHorizontal: true,
        // pageSnap: false,
        // pageFling: false,
        onRender: (pages) => setState(() => _pages = pages!),
        onViewCreated: (controller) =>
            setState(() => _controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => _indexPage = indexPage!),
      )
    );
  }

  

  
}
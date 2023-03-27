// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/pages/HomePage.dart';
import 'package:flutter/material.dart';

class BottomBarMenu extends StatefulWidget {
  const BottomBarMenu({Key? key}) : super(key: key);

  @override
  _BottomBarMenuState createState() => _BottomBarMenuState();
  
}

class _BottomBarMenuState extends State<BottomBarMenu> {

  late Management _management;


   @override
  Widget build(BuildContext context) {
    _management = Provider.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent)
      ),
      child: Row(
        children: <Widget>[
          const Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () {
              _management.setIndex=0;
              Navigator.pushNamed(context, HomePage.tableRoute);
            },
            child: Icon(
              Icons.table_chart,
              size: 50,
              color: _management.getIndex == 0 ? Colors.blue[700] : Colors.grey,
            ),
          ),
          const Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () {
              _management.setIndex=1;
              Navigator.pushNamed(context, HomePage.homeRoute);
            },
            onDoubleTap: ()async{
              await _management.viewSubscripciptionsRequest();
              _management.setIndex=1;
              Navigator.pushNamed(context, HomePage.homeRoute);
            },
            child: Icon(
              Icons.home,
              size: 50,
              color: _management.getIndex == 1 ? Colors.blue[700] : Colors.grey,
            ),
          ),
          const Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () {
              _management.setIndex=2;
              Navigator.pushNamed(context, HomePage.calendarRoute);
            },
            child: Icon(
              Icons.calendar_month,
              size: 50,
              color: _management.getIndex == 2 ? Colors.blue[700] : Colors.grey,
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}


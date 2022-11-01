// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/pages/HomePage.dart';
import 'package:agenda_movil/src/pages/CreateActivityPage.dart';
import 'package:agenda_movil/src/pages/CreateMatterPage.dart';
import 'package:agenda_movil/src/pages/TeacherPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class BottomBarMenu extends StatefulWidget {
  BottomBarMenu({Key? key}) : super(key: key);

  @override
  _BottomBarMenuState createState() => _BottomBarMenuState();
  
}

class _BottomBarMenuState extends State<BottomBarMenu> {

  late Management _management;


   @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _management = Provider.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent)
      ),
      child: Row(
        children: <Widget>[
          const Expanded(child: SizedBox()),
          IconButton(
            icon: Icon(
              Icons.table_chart,
              size: 40,
              color: _management.getIndex == 0 ? Colors.blue[700] : Colors.grey,
            ),
            onPressed: () {
              _management.setIndex=0;
              Navigator.pushReplacementNamed(context, HomePage.TableRoute);
            },
            splashColor: Colors.white,
          ),
          const Expanded(child: SizedBox()),
          IconButton(
            icon: Icon(
              Icons.home,
              size: 40,
              color: _management.getIndex == 1 ? Colors.blue[700] : Colors.grey,
            ),
            onPressed: () {
              _management.setIndex=1;
              Navigator.pushReplacementNamed(context, HomePage.HomeRoute);
            },
            splashColor: Colors.white,
          ),
          const Expanded(child: SizedBox()),
          IconButton(
            icon: Icon(
              Icons.calendar_month,
              size: 40,
              color: _management.getIndex == 2 ? Colors.blue[700] : Colors.grey,
            ),
            onPressed: () {
              _management.setIndex=2;
              Navigator.pushReplacementNamed(context, HomePage.CalendarRoute);
            },
            splashColor: Colors.white,
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

class _BBMPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.blue[700]!, -1, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
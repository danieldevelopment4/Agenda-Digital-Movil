import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:agenda_movil/src/Logic/Provider.dart';
import 'package:agenda_movil/src/pages/Home.dart';
import 'package:agenda_movil/src/pages/createActivity.dart';
import 'package:agenda_movil/src/pages/createSubject.dart';
import 'package:agenda_movil/src/pages/createTeacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class BottomBarMenu extends StatefulWidget {
  const BottomBarMenu({Key? key}) : super(key: key);

  @override
  _BottomBarMenuState createState() => _BottomBarMenuState();
}

class _BottomBarMenuState extends State<BottomBarMenu> {

  late Management management;
  int _currentIndex = 0;

  setBottomBarIndex(int index) {
    _currentIndex = index;
    management.setIndex=index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    management = Provider.of(context);
    _currentIndex = management.getIndex;
    
    return Stack(
      children: [
        CustomPaint(
          size: Size(size.width, 80),
          painter: _BBMPainter(),
        ),
        Center(
          heightFactor: 0.6,
          child: SpeedDial(
            icon: Icons.add,
            backgroundColor: Colors.blue[700],
            overlayColor: Colors.black,
            overlayOpacity: 0.4,
            children: <SpeedDialChild>[ 
              SpeedDialChild(
                label: "Agregar Docente",
                child: const Icon(Icons.account_circle),
                onTap: () => Navigator.pushReplacementNamed(context, CreateTeacher.route)
              ),
              SpeedDialChild(
                label: "Agregar Actividad",
                child: const Icon(Icons.local_activity),
                onTap: () => Navigator.pushReplacementNamed(context, CreateActivity.route)
              ),
              SpeedDialChild(
                label: "Agregar Materia",
                child: const Icon(Icons.subject),
                onTap: () => Navigator.pushReplacementNamed(context, CreateSubject.route)
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 40,
                  color: _currentIndex == 0 ? Colors.blue[700] : Colors.grey,
                ),
                onPressed: () {
                  setBottomBarIndex(0);
                  Navigator.pushReplacementNamed(context, Home.route);
                },
                splashColor: Colors.white,
              ),
              Container(
                width: size.width * 0.20,
              ),
              IconButton(
                  icon: Icon(
                    Icons.calendar_month,
                    size: 40,
                    color: _currentIndex == 2 ? Colors.blue[700] : Colors.grey,
                  ),
                  onPressed: () {
                    setBottomBarIndex(2);
                  }),
            ],
          ),
        )
      ],
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
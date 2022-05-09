import 'package:flutter/material.dart';

class SplashScreenWidget extends StatefulWidget {
  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131619),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          color: Color(0xFF206BB5),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: Image.asset(
              'assets/images/bg_login.png',
            ).image,
          ),
        ),
      ),
    );
  }
}

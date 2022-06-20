import 'package:agenda_movil/src/pages/Login.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: const <Widget>[
                Text("User Name"),
                CircleAvatar(
                  child: Icon(Icons.account_circle),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox(),),
          const Divider(),
          TextButton(
            child: Row(
              children: const <Widget>[
                Text("Cerrar sesion"),
                Icon(Icons.logout)
              ],
            ),
            onPressed: () => Navigator.pushNamed(context, Login.route),
          )
        ],
      ),
    );
  }
}
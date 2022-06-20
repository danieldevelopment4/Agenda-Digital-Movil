import 'package:flutter/material.dart';

import 'Management.dart';

class Provider extends InheritedWidget {
  /*esta clase permite el desarrollo de una arquitectura singlenton, es de cir un solo management para toda la app lo que permite un 
  correcto funcionamiento de la mismas al no saturar las unidades de almasenamiento dinamicas, asi mismo como al permitir que la info
  se mantenga "persistente" sin importar el panel en que se encuentre */

  final management = Management();

  Provider({Key? key, required Widget child}) :super(key: key, child: child);

  @override
  bool updateShouldNotify(Provider oldWidget) => true;

  static Management of (BuildContext context){ 
    return (context.dependOnInheritedWidgetOfExactType<Provider>()as Provider).management;
  }

}
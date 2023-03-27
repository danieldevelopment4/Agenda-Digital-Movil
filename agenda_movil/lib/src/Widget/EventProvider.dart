import 'dart:html';

import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier{
  final List<Event> _events = List.empty(growable: true);

  void addEvent(Event event){
    _events.add(event);

    notifyListeners();
  }

}
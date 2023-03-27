// ignore_for_file: file_names


import 'package:agenda_movil/src/Widget/Event.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource{

  EventDataSource(List<Event> appointments){
    this.appointments = appointments;
  }

   @override
  DateTime getStartTime(int index) {
    return getEvent(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    DateTime.now().add(Duration(days: -5));
    return getEvent(index).to;
  }

  @override
  String getSubject(int index) {
    return getEvent(index).title;
  }

  @override
  Color getColor(int index) {
    return Colors.blue[600]!;
  }

  @override
  bool isAllDay(int index) {
    return getEvent(index).isAllDay;
  }

  Event getEvent(int index){
    return appointments![index] as Event;
  }

}
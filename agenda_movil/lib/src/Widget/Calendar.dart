// ignore_for_file: file_names, must_be_immutable

import 'package:agenda_movil/src/Model/ActivityModel.dart';
import 'package:agenda_movil/src/Model/MatterModel.dart';
import 'package:agenda_movil/src/Model/SubscriptionModel.dart';
import 'package:agenda_movil/src/Widget/Event.dart';

import 'package:agenda_movil/src/Logic/Management.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../Logic/Provider.dart';
import 'EventDataSource.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Management _management;

  @override
  Widget build(BuildContext context) {
    _management = Provider.of(context);
    return SfCalendar(
      dataSource: EventDataSource(_getCalendarEvents()),
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
    );
  }

  List<Event> _getCalendarEvents(){
    List<Event> list = List.empty(growable: true);
    List<SubscriptionModel> subscriptions = _management.getSubscriptionList;
    List<ActivityModel> activities;
    for(int i=0; i< subscriptions.length; i++){
      activities = subscriptions[i].getMatter.getActivitiesList;
      for(int j=0; j< activities.length; j++){
        
      }
    }
    return list;
  }
}
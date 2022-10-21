// ignore_for_file: file_names

import 'dart:async';

import 'package:agenda_movil/src/API/RateRequest.dart';
import 'package:agenda_movil/src/API/RegisterRequest.dart';
import 'package:agenda_movil/src/API/LogingRequest.dart';
import 'package:agenda_movil/src/API/SubscriptionRequest.dart';
import 'package:agenda_movil/src/Logic/Streams.dart';


class Management{
  // String host = "https://back-end-agenda-digital.herokuapp.com";
  // String host = "http://127.0.0.1:8080";
  String host = "https://40e2-2800-e2-ab00-26d-2d19-a751-4856-6bd8.ngrok.io";
  Map<String, String> header = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  var streams = Streams();

//BottonMenuBar
  int _currentIndex = 0;

  int get getIndex {
    return _currentIndex;
  }

  set setIndex(int index) {
    _currentIndex = index;
  }

  //login
  Future<Map<String, dynamic>> logingRequest(Map<String, String> body) {
    return LogingRequest().loggin(host, header, body);
  }

  //register
  Future<Map<String, dynamic>> registerRequest(Map<String, String> body) {
    return RegisterRequest().register(host, header, body);
  }

  //rate
  Future<Map<String, dynamic>> rateRequest(Map<String, String> body) {
    return RateRequest().rate(host, header, body);
  }

  //subscripciption
  Future<Map<String, dynamic>> subscripciptionRequest(Map<String, String> body) {
    return SubscriptionRequest().viewSubscriptions(host, header, body);
  }
}

// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:agenda_movil/src/Persistence/Percistence.dart';

import 'package:http/http.dart' as http;

class SubscriptionRequest {

  final Percistence _percistence = Percistence();

  Future<bool> viewSubscriptions(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      var url = Uri.parse( host+"/subscription/show");
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        _percistence.subscription = response.body;
        return true; 
      }
    } on SocketException catch (e) {
      return false;
    }
    return null!;
  }

  Future<Map<String, dynamic>> subscribe(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      var url = Uri.parse(host+"/subscription/subscribe");
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "El registro ha sido exitoso"
        };
      }else if(response.statusCode == 400){
        return {
          "status": false, // "ERROR"
          "type":"info",
          "message": "Ya te encuentras registrado en esta materia"
        };
      }
    }on SocketException catch(e){
      return {
        "status": false, // "ERROR"
        "type":"error",
        "message": "No pudimos completar la accion, revisa si cuentas con conexion a internet"
      };
    }
    return null!;
  }

}
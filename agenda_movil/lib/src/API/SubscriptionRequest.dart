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
    } on SocketException{
      return false;
    }
    throw Exception;
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
    }on SocketException{
      return {
        "status": false, // "ERROR"
        "type":"error",
        "message": "No pudimos completar la accion, revisa si cuentas con conexion a internet"
      };
    }
    throw Exception;
  }

  Future<Map<String, dynamic>> unsubscribe(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      print('body: ${body}');
      var url = Uri.parse(host+"/subscription/unsubscribe");
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "Has salido del grupo de manera exitosa"
        };
      }else if(response.statusCode == 400){
        return {
          "status": false, // "ERROR"
          "type":"info",
          "message": "ERROR...http400"
        };
      }
    }on SocketException{
      return {
        "status": false, // "ERROR"
        "type":"error",
        "message": "No pudimos completar la accion, revisa si cuentas con conexion a internet"
      };
    }
    throw Exception;
  }
  
  Future<Map<String, dynamic>> aprobeSubscriptionRequest(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      // print('Response body: ${body}');
      var url = Uri.parse(host+"/subscription/aprobe");
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "Se ha aprobado la peticion del estudiante exitosamente"
        };
      }else if(response.statusCode == 400){
        return {
          "status": false, // "ERROR"
          "type":"info",
          "message": "ERROR de dudosa procedencia::aprobacion"
        };
      }
    }on SocketException{
      return {
        "status": false, // "ERROR"
        "type":"error",
        "message": "No pudimos completar la accion, revisa si cuentas con conexion a internet"
      };
    }
    throw Exception;
  }

  Future<Map<String, dynamic>> deniedSubscriptionRequest(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      var url = Uri.parse(host+"/subscription/denied");
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "Se ha denegado el acceso a esta materia para el estudiante"
        };
      }else if(response.statusCode == 400){
        return {
          "status": false, // "ERROR"
          "type":"info",
          "message": "ERROR de dudosa procedencia::rechazo"
        };
      }
    }on SocketException{
      return {
        "status": false, // "ERROR"
        "type":"error",
        "message": "No pudimos completar la accion, revisa si cuentas con conexion a internet"
      };
    }
    throw Exception;
  }

}
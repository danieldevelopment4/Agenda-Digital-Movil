// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class MatterRequest {

  Future<Map<String, dynamic>> create(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      print('body: ${body}');
      var url = Uri.parse(host+"/matter/create");
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "El registro ha sido exitoso"
        };
      }else if(response.statusCode == 400){
        return {
          "status": false, // "ERROR"
          "type":"info",
          "message": "Ya te encuentras registrado en una materia con este mismo nombre"
        };
      }
    } on SocketException catch (e) {//si falla la conexion
      return {
        "status": false, // "ERROR"
        "type":"error",
        "message": "No pudimos completar la accion, revisa si cuentas con conexion a internet"
      };
    }
    return null!;
  }

  Future<Map<String, dynamic>> updateTeacher(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      var url = Uri.parse(host+"/matter/update");
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "Se a modificado exitosamente la informacion de la materia"
        };
      }else if(response.statusCode == 400){
        return {
          "status": false, // "ERROR"
          "type":"info",
          "message": "no pudimos realizar esta accion...perdon"
        };
      }
    } on SocketException catch (e) {//si falla la conexion
      return {
        "status": false, // "ERROR"
        "type":"error",
        "message": "No pudimos completar la accion, revisa si cuentas con conexion a internet"
      };
    }
    return null!;
  }

}

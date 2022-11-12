// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class SubmitRequest{

  Future<Map<String, dynamic>> create(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      var url = Uri.parse(host+"/submit/create");
      // print('Response body: ${body}');
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "La entrega ha sido agregada con exito"
        };
      }else if(response.statusCode == 400){
        return {
          "status": false, // "ERROR"
          "type":"info",
          "message": "Hubo un fallo inesperado, http::400"
        };
      }
    } on SocketException{//si falla la conexion
      return {
        "status": false, // "ERROR"
        "type":"error",
        "message": "No pudimos completar la accion, revisa si cuentas con conexion a internet"
      };
    }
    throw Exception;
  }

  Future<Map<String, dynamic>> edit(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      var url = Uri.parse(host+"/submit/update");
      // print('Response body: ${body}');
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "La entrega ha sido actualizada con exito"
        };
      }else if(response.statusCode == 400){
        return {
          "status": false, // "ERROR"
          "type":"info",
          "message": "Hubo un fallo inesperado, http::400"
        };
      }
    } on SocketException{//si falla la conexion
      return {
        "status": false, // "ERROR"
        "type":"error",
        "message": "No pudimos completar la accion, revisa si cuentas con conexion a internet"
      };
    }
    throw Exception;
  }

  Future<Map<String, dynamic>> delete(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      var url = Uri.parse(host+"/submit/delete");
      // print('Response body: ${body}');
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "La entrega ha sido eliminada con exito"
        };
      }else if(response.statusCode == 400){
        return {
          "status": false, // "ERROR"
          "type":"info",
          "message": "Hubo un fallo inesperado, http::400"
        };
      }
    } on SocketException{//si falla la conexion
      return {
        "status": false, // "ERROR"
        "type":"error",
        "message": "No pudimos completar la accion, revisa si cuentas con conexion a internet"
      };
    }
    throw Exception;
  }

}
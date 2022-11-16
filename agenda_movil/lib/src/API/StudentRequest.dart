// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:agenda_movil/src/Persistence/Percistence.dart';
import 'package:http/http.dart' as http;

class StudentRequest {

  final Percistence _percistence = Percistence();

  Future<Map<String, dynamic>> loggin(String host, Map<String, String> header, Map<String, String> body) async {
    try {
      var url = Uri.parse( host+"/student/loggin");
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        _percistence.student = response.body;
        return {
          "status": true, // "OK"
        };
      }else if (response.statusCode == 401) {
        return {
          "status": false, // "ERROR"
          "message": "Las credenciales ingresadas no han podido ser validadas, por favor rectifica e intenta nuevamente"
        };
      }
    } on SocketException{
      return {
        "status": false, // "ERROR"
        "message": "Error en la conexion"
      };
    }
    throw Exception;
  }

  Future<Map<String, dynamic>> register(String host, Map<String, String> header, Map<String, String> body) async {
    try {
      var url = Uri.parse(host+"/student/register");
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        _percistence.student = response.body;
        return {
          "status": true, // "OK"
          "message": "La cuenta ha sido registrada exitosamente"
        };
      }else if (response.statusCode == 400) {
        return {
          "status": false, // "ERROR"
          "message": "Esta direccion de correo ya se encuentra ocupada"
        };
      }
    } on SocketException{
      return {
        "status": false, // "ERROR"
        "message": "Eror en la conexion"
      };
    }
    throw Exception;
  }

  Future<Map<String, dynamic>> recoverPassword(String host, Map<String, String> header, Map<String, String> body) async {
    try {
      print('body: ${body}');
      var url = Uri.parse( host+"/student/recoverPassword");
      print('url: ${url}');
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        _percistence.student = response.body;
        return {
          "status": true, // "OK"
          "message": "Revisa tu correo, pronto te llegara tu nueva contraseña"
        };
      }else if (response.statusCode == 400) {
        return {
          "status": false, // "ERROR"
          "message": "El correo ingresado no esta registrado"
        };
      }
    } on SocketException{
      return {
        "status": false, // "ERROR"
        "message": "Error en la conexion"
      };
    }
    throw Exception;
  }

}

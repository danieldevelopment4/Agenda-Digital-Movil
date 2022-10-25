// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ActivityRequest{

  Future<Map<String, dynamic>> create(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      var url = Uri.parse(host+"/activity/create");
      // print('Response body: ${body}');
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "La actividad ha sido agregada con exito"
        };
      }else if(response.statusCode == 400){
        return {
          "status": false, // "ERROR"
          "type":"info",
          "message": "Hubo un fallo inesperado, http::400"
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
// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class VersionRequest{

  Future<Map<String, dynamic>> lookForUpdate(String host, Map<String, String> header, Map<String, String> body) async {
    try {
      // print('body: ${body}');
      var url = Uri.parse( host+"/student/setPassword");
      // print('url: ${url}');
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "¡¡Genial!! Tu nueva contraseña ya se encuentra lista"
        };
      }else if (response.statusCode == 400) {
        return {
          "status": false, // "ERROR"
          "message": "..."
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
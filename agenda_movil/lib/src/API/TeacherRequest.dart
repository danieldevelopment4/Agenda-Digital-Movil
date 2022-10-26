// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class TeacherRequest {
  Future<Map<String, dynamic>> create(String host, Map<String, String> header, Map<String, dynamic> body) async {
    try {
      var url = Uri.parse( host+"/teacher/create");
      var response = await http.post(url, body: jsonEncode(body), headers: header);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return {
          "status": true, // "OK"
          "message": "El registro ha sido exitoso"
        };
      }else if (response.statusCode == 400) {
        return {
          "status": false, // "ERROR"
          "message": "Hubo un error en el registro... mas raro"
        };
      }
    } on SocketException catch (e) {
      return {
        "status": false, // "ERROR"
        "message": "Eror en la conexion"
      };
    }
    return null!;
  }
}
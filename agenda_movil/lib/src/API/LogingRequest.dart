// ignore_for_file: file_names

import 'dart:convert';

import 'package:agenda_movil/src/Persistence/Percistence.dart';
import 'package:http/http.dart' as http;

class LogingRequest {

  final Percistence _percistence = Percistence();

  Future<Map<String, dynamic>> loggin(String host, Map<String, String> header, Map<String, String> body) async {
    var url = Uri.parse( host+"/student/loggin");
    
    var response = await http.post(url, body: jsonEncode(body), headers: header);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      _percistence.student = response.body;
      return {
        "status": true, // "OK"
      };
    }
    return {
      "status": false, // "ERROR"
      "message": "Las credenciales ingresadas no han podido ser validadas, por favor rectifica e intenta nuevamente"
    };
  }

}

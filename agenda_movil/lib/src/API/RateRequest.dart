// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;

class RateRequest {
  Future<Map<String, dynamic>> rate(String host, Map<String, String> header, Map<String, String> body) async {
    var url = Uri.parse(host+"/calification/create");
    var response =
        await http.post(url, body: jsonEncode(body), headers: header);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return {
        "status": true, // "OK"
      };
    }
    return {
      "status": false, // "ERROR"
      "message": "Parece que hubo un fallo en el envio de tu valoracion"
    };
  }
}
import 'dart:convert';

import 'package:http/http.dart' as http;

class LogingRequest {
  Future<Map<String, dynamic>> loggin(Map<String, String> body) async {
    var url = Uri.parse(
        "https://back-end-agenda-digital.herokuapp.com/student/loggin");
    Map<String, String> header = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
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
      "message": "Las credenciales ingresadas no han podido ser validadas, por favor rectifica e intenta nuevamente"
    };
  }
}

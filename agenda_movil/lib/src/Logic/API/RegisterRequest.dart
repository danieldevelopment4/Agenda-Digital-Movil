import 'dart:convert';

import 'package:http/http.dart' as http;

class RegisterRequest {
  Future<Map<String, dynamic>> register(Map<String, String> body) async {
    var url = Uri.parse(
        "https://back-end-agenda-digital.herokuapp.com/student/register");
    Map<String, String> header = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.post(url, body: jsonEncode(body), headers: header);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return {
        "status": true, // "OK"
        "message": "La cuenta ha sido registrada exitosamente"
      };
    }
    return {
      "status": false, // "ERROR"
      "message":
          "El email ingresado ya se encuentra ocupado, por favor intente nuevamente con otro email"
    };
  }
}

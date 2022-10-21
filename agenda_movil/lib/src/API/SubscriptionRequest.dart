import 'dart:convert';

import 'package:agenda_movil/src/Model/SubscriptionModel.dart';
import 'package:agenda_movil/src/Persistence/Percistence.dart';

import 'package:http/http.dart' as http;

class SubscriptionRequest {

  final Percistence _percistence = Percistence();

  Future<Map<String, dynamic>> viewSubscriptions(String host, Map<String, String> header, Map<String, String> body) async {
    var url = Uri.parse( host+"/subscription/show");
    
    var response = await http.post(url, body: jsonEncode(body), headers: header);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      _percistence.subscription = response.body;
      return {
        "status": true, // "OK"
      };
    }
    return {
      "status": false, // "ERROR"
      "emoji": "(⊙_⊙)？",
      "message": "Revisa tu conexion a internet e intenta de nuevo, no pudimos conextar con los servidores"
    };
  }

}
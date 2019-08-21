import 'dart:convert';

import 'package:http/http.dart' as http;

import './API.dart';

class NonUserAPI extends API {

  static const String _URI = API.BASE_URI + '/nonuser';

  Future<dynamic> post(String uri, Map<String, dynamic> body) async {
    final response = await http.post(_URI + uri, body: body);
    switch(response.statusCode) {
      case 200:
        return json.decode(response.body);
      default:
        return null;
    }
  }
}
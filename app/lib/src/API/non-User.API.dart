import 'dart:convert';

import 'package:http/http.dart' as http;

import './API.dart';

class NonUserAPI extends API {

  static const String _URI = API.BASE_URI + '/nonuser';

  Future<dynamic> get(String uri, {Map<String, dynamic> header}) async {
    print(json.encode(header));

    final response = await http.get(_URI + uri, headers: header);
    switch(response.statusCode) {
      case 200:
        return json.decode(response.body);
      default:
        return null;
    }
  }

  Future<dynamic> post(String uri, {Map<String, dynamic> body, Map<String, String> headers}) async {
    print(json.encode(body));

    if(headers != null) {
      if(!headers.containsKey(Header.CONTENT_TYPE)) {
        headers.addAll({
          Header.CONTENT_TYPE: Header.APP_JSON
        });
      }
    } else {
      headers = {
        Header.CONTENT_TYPE: Header.APP_JSON
      };
    }

    print('API to -> ${_URI + uri}');

    final response = await http.post(_URI + uri, body: json.encode(body), headers: headers);
    switch(response.statusCode) {
      case 200:
        return json.decode(response.body);
      default:
        return null;
    }
  }
}
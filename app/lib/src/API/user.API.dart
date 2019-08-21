import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

import 'package:listchat/src/Navigator/StringScreen.dart';

import './API.dart';

class UserAPI extends API {

  BuildContext _context;

  static const String _URI = API.BASE_URI + '/user';

  UserAPI(BuildContext context) {
    _context = context;
  }

  Future<dynamic> get(String uri) async {
    final response = await http.get(_URI + uri, headers: { Header.AUTHORIZATION: API.getToken() });

    switch(response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 401:
        Navigator.of(_context).popAndPushNamed(SIGNINSCREEN);
        break;
    }
  }

  Future<dynamic> post(String uri, Map<String, dynamic> body) async {
    final response = await http.post(_URI + uri, body: body, headers: { Header.AUTHORIZATION: API.getToken() });

    switch(response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 401:
        Navigator.of(_context).pushReplacementNamed(SIGNINSCREEN);
        break;
      default:
        return null;
    }
  }
}
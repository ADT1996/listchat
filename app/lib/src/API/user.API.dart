import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

import 'package:listchat/src/Navigator/StringScreen.dart';
import 'package:listchat/src/Service/user.Service.dart';

import './API.dart';

class UserAPI extends API {

  BuildContext _context;

  static const String _URI = API.BASE_URI + '/auth';

  UserAPI(BuildContext context) {
    _context = context;
  }

  Future<dynamic> get(String uri) async {
    final response = await http.get(_URI + uri, headers: { Header.AUTHORIZATION: API.getToken() });

    switch(response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 401:
        Navigator.of(_context).pushNamedAndRemoveUntil(SIGNINSCREEN, (Route pre) => false);
        Socket.close();
        break;
      default:
        break;
    }
    return null;
  }

  Future<dynamic> post(String uri, Map<String, dynamic> body) async {
    final response = await http.post(_URI + uri, body: json.encode(body), headers: { Header.AUTHORIZATION: API.getToken() });

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
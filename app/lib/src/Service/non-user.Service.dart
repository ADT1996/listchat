import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:listchat/src/API/non-User.API.dart';
import 'package:listchat/src/Model/Models.dart';
import 'package:listchat/src/Service/base.Service.dart';
import './service.Common.dart';

class NonUserService extends Service {

  NonUserAPI _nonUserAPI;

  NonUserService() : super() {
    _nonUserAPI = NonUserAPI();
  }

  Future<User> login(String email, String password) async {
    Map<String, String> body = {
      Parameter.EMAIL: email,
      Parameter.PASSWORD: password
    };
  
    try{

      final data = await _nonUserAPI.post('/login', body);

      if(data == null)
        return null;

      return User(
        id: data[Parameter.ID],
        birthday: DateTime.parse(data[Parameter.BIRTHDAY]),
        email: data[Parameter.EMAIL] as String,
        gender: data[Parameter.GENDER] as bool,
        firstName: data[Parameter.FIRSTNAME] as String,
        lastName: data[Parameter.LASTNAME] as String,
        token: data[Parameter.TOKEN] as String,
      );

    } catch(ex) {
      print(ex);
      return null;
    }
}

  Future<String> signUp({
    @required String email,
    @required String password,
    @required String firstName,
    @required String lastName,
    @required String birthday,
    @required bool gender
  }) async {

    final response = await _nonUserAPI.post('/signup',
      {
        Parameter.EMAIL: email,
        Parameter.PASSWORD: password,
        Parameter.FIRSTNAME: firstName,
        Parameter.LASTNAME: lastName,
        Parameter.BIRTHDAY: birthday,
        Parameter.GENDER: gender.toString(),
      }
    );

    if(response.statusCode == 200) {
      return json.decode(response.body)[Parameter.RESULT];
    }
    return null;
  }
}
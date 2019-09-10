import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:listchat/src/API/non-User.API.dart';
import 'package:listchat/src/Common/Common.dart';
import 'package:listchat/src/Model/Models.dart';
import 'package:listchat/src/Service/base.Service.dart';
import './service.Common.dart';

class NonUserService extends Service {

  NonUserAPI _nonUserAPI;

  NonUserService() : super() {
    _nonUserAPI = NonUserAPI();
  }

  Future<User> login(String email, String password) async {
    try{

      final data = await _nonUserAPI.post('/login', body: {
        Parameter.EMAIL: email,
        Parameter.PASSWORD: password
      });

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

    final response = await _nonUserAPI.post('/signup', body: {
      Parameter.EMAIL: email,
      Parameter.PASSWORD: password,
      Parameter.FIRSTNAME: firstName,
      Parameter.LASTNAME: lastName,
      Parameter.BIRTHDAY: birthday,
      Parameter.GENDER: gender,
    });
    return response[Parameter.RESULT];
  }

  Future<String> getCertKey() async {
    final resposne = await _nonUserAPI.get('/getcertkey');
    return resposne['key'];
  }

  Future<User> loginByFirebase(FirebaseUser user, String certKey) async {
    final resposne = await _nonUserAPI.post('/loginByFirebase', body: {
      Parameter.EMAIL: user.email,
      Parameter.PHONE: user.phoneNumber,
      Parameter.FIRSTNAME: user.displayName.split(' ')[0],
      Parameter.LASTNAME: user.displayName.split(' ').skip(1).join(' '),
      Parameter.BIRTHDAY: ''
    },
    headers: {
      'certkey': certKey
    });
    if(resposne == null) {
      return null;
    }
    return resposne[Parameter.RESULT] == 'OK' ? Common.objectToUser(resposne[Parameter.USER]) : null;
  }
}
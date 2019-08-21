import 'package:flutter/material.dart';

import 'package:listchat/src/Navigator/StringScreen.dart';
import 'package:listchat/src/Service/non-user.Service.dart';
import 'package:listchat/src/Model/Models.dart';

import './main.dart';

class Controller {
  SigninState _screen;

  String email = '';
  String password = '';

  NonUserService _service;

  Controller(SigninState screen) {
    _screen = screen;
    _service = NonUserService();
  }

  void onChangedEmail(String email) => this.email = email;
  void onchangedPassword(String password) => this.password = password;

  void Function() login(BuildContext context) => () async {
    print('Login\n');
    User user = await _service.login(email, password);

    if(user == null) {
      print('login fail');
      return;
    }

    print(user.getEmail());
    print(user.getGender());
    print(user.getLastName());
    print(user.getFirstName());
    print(user.getBirthday());
    print(user.getToken());
    Navigator.of(context).pushReplacementNamed(HOMESCREEN, arguments: user);
  };

  void Function() signUp(BuildContext context) => () {
    print('Sign up\n');
    Navigator.of(context).pushNamed(REGISTRYSCREEN);
  };
}
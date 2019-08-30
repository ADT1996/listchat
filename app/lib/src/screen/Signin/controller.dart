import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

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

  void Function() login() => () async {
    print('Login\n');
    User user = await _service.login(email, password);

    if(user == null) {
      print('login fail');
      Toast.show('Email or password is wrong.',_screen.context, duration: 2, gravity: Toast.BOTTOM);
      return;
    }

    print(user.getEmail());
    print(user.getGender());
    print(user.getLastName());
    print(user.getFirstName());
    print(user.getBirthday());
    print(user.getToken());
    Navigator.of(_screen.context).pushReplacementNamed(HOMESCREEN, arguments: user);
  };

  void Function() signUp() => () {
    print('Sign up\n');
    Navigator.of(_screen.context).pushNamed(REGISTRYSCREEN);
  };
}
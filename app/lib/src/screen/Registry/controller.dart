import 'package:flutter/widgets.dart';
import 'package:listchat/src/Service/non-user.Service.dart';

import './main.dart';

class Controller {

  String email;
  String password;
  String firstName;
  String lastName;
  String birthday;

  bool gender;
  
  RegistryState _screen;

  NonUserService _service;

  Controller(RegistryState screen) {
    _screen = screen;
    _service = NonUserService();
    birthday = password = firstName = lastName = email = '';
    gender = false;
  }

  void onChangedEmail(String email) => this.email = email;
  void onChangedPassword(String password) => this.password = password;
  void onChangedFirstName(String firstName) => this.firstName = firstName;
  void onChangedLastName(String lastName) => this.lastName = lastName;
  void onChangedGender(bool gender) => this.gender = gender;

  void onChangedBirthday(String birthday) => this.birthday = birthday;

  void Function() signUp(BuildContext context) => () async {
    final result =  await _service.signUp(email: email, password: password, birthday: birthday, firstName: firstName, lastName: lastName, gender: gender);
    if(result == 'OK') {
      Navigator.of(context).pop();
      return;
    }

    print('sign up fail');
  };

}
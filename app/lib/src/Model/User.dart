import 'package:flutter/foundation.dart';

import './Model.dart';

class User extends Model {

  bool _gender;

  String _id;
  String _lastName;
  String _firstName;
  DateTime _birthday;
  String _email;
  String _token;

  User({
    @required String id,
    @required DateTime birthday,
    @required String email,
    @required String firstName,
    @required String lastName,
    String token,
    @required bool gender,

  }) : super() {
    _id = id;
    _birthday = birthday;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _token = token;
    _gender = gender;
  }

  bool getGender() => _gender;

  String getId() => _id;
  String getLastName() => _lastName;
  String getFirstName() => _firstName;
  DateTime getBirthday() => _birthday;
  String getEmail() => _email;
  String getToken() => _token;

  void setGender(bool gender) => _gender = gender;
  void setLastName(String lastName) => _lastName = lastName;
  void setFirstName(String firstName) => _firstName = firstName;
  void setBirthday(DateTime birthday) => _birthday = birthday;
  void setEmail(String email) => _email = email;
}
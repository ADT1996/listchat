import 'package:flutter/material.dart';
import 'package:listchat/src/Components/Component.dart';
import 'package:listchat/src/screen/Registry/controller.dart';

import './string.dart' as STRING;

class Registry extends StatefulWidget {
  Registry() : super();

  @override
  RegistryState createState() => RegistryState();

}

class RegistryState extends State<Registry> {
  
  Controller _controller;

  RegistryState() :super() {
    _controller = Controller(this);
  }

  Widget _buildButton(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Button(
        color: Colors.blue,
        text: STRING.ERGISTRYBUTTON,
        prefixIcon: Icons.person_add,
        highlightedBorderColor: Colors.blue[700],
        onPressed: _controller.signUp(context),
      )
    ],
  );

  List<Widget> _buildTextInputs(BuildContext context) => <Widget>[
    TextInput(
      color: Colors.blue,
      verticalPadding: 5,
      keyboardType: TextInputType.emailAddress,
      labelText: STRING.EMAIL,
      onChanged: _controller.onChangedEmail,
    ),
    TextInput(
      color: Colors.blue,
      verticalPadding: 5,
      keyboardType: TextInputType.text,
      obscureText: true,
      labelText: STRING.PASSWORD,
      onChanged: _controller.onChangedPassword,
    ),
    TextInput(
      color: Colors.blue,
      verticalPadding: 5,
      keyboardType: TextInputType.text,
      labelText: STRING.FIRSTNAME,
      onChanged: _controller.onChangedFirstName,
    ),
    TextInput(
      color: Colors.blue,
      verticalPadding: 5,
      keyboardType: TextInputType.text,
      labelText: STRING.LASTNAME,
      onChanged: _controller.onChangedLastName,
    ),
    TextInput(
      color: Colors.blue,
      verticalPadding: 5,
      maxLength: 10,
      keyboardType: TextInputType.datetime,
      labelText: STRING.BIRTHDAY,
      onChanged: _controller.onChangedBirthday,
    ),
    CustomCheckbox(
      value: _controller.gender,
      onChanged: _controller.onChangedGender,
      color: Colors.blue,
      label: Text(STRING.MALE,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.blue,
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) => ThemeApp(
    isLoading: false,
    isShowingBottomBar: false,
    title: Text(STRING.TITLE),
    child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ..._buildTextInputs(context),
            _buildButton(context),
          ],
        ),
      ),
    ),
  );

}
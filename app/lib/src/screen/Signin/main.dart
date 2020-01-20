import 'dart:io';

import 'package:flutter/material.dart';

import 'package:listchat/src/Components/Component.dart';

import './controller.dart';
import './style.dart';
import './string.dart' as STRING;

/*
  @params don't params
*/
class Signin extends StatefulWidget {
  Signin() : super();

  @override
  SigninState createState() => SigninState();
}

class SigninState extends State<Signin> {
  Controller _controller;
  SigninStyle _style;

  SigninState() : super() {
    _controller = Controller(this);
    _style = SigninStyle();
  }

  Widget _buildGoogleSignInSection() {
    return OutlineButton(
      borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
      highlightedBorderColor: Colors.red,
      splashColor: Color.lerp(Colors.redAccent, null, 0.9),
      highlightColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              'google_logo.png',
              height: 28,
              width: 28,
            ),
          ),
          Text(
            STRING.GOOGLE_LOGIN,
            style: TextStyle(color: Colors.redAccent),
          )
        ],
      ),
      onPressed: _controller.pressGoogleSignIn,
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Button(
            text: STRING.REGISTRYBUTTON,
            prefixIcon: Icons.person_add,
            color: Colors.teal,
            horizontalPadding: 5,
            onPressed: _controller.signUp(),
            highlightedBorderColor: Colors.teal[700],
          ),
          Button(
            text: STRING.LOGINBUTTON,
            prefixIcon: Icons.input,
            color: Colors.blue,
            highlightedBorderColor: Colors.blue[700],
            horizontalPadding: 5,
            onPressed: _controller.login(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextInput(
              onChanged: _controller.onChangedEmail,
              color: Colors.blue,
              // icon: Icons.alternate_email,
              keyboardType: TextInputType.emailAddress,
              labelText: STRING.EMAIL,
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextInput(
              onChanged: _controller.onchangedPassword,
              color: Colors.blue,
              // icon: Icons.security,
              keyboardType: TextInputType.text,
              labelText: STRING.PASSWORD,
              obscureText: true,
            )),
        _buildButtons(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) => ThemeApp(
        isLoading: _controller.isLoading,
        title: Text(STRING.TITLE),
        isShowingBottomBar: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Y Chat', style: _style.titleStyle),
              Container(
                child: Padding(
                    padding: EdgeInsets.all(5.0), child: _buildInputs()),
              ),
              _buildGoogleSignInSection()
            ],
          ),
        ),
      );
}

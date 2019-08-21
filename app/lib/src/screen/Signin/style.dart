import 'package:flutter/material.dart';

class SigninStyle {

  TextStyle titleStyle = TextStyle(
    color: Colors.blueAccent,
    fontSize: 48,
    fontWeight: FontWeight.w900
  );

  TextStyle textStyle = TextStyle(
    color: Colors.blue,
    fontSize: 18,
    fontWeight: FontWeight.w900
  );

  InputDecoration textDecoration({
    String labelText = '',
    Color color = Colors.grey,
    Color focusedColor = Colors.grey,
    IconData icon
  })
  => InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: color
      )
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: focusedColor,
      )
    ),
    icon: icon == null ? null : Icon(icon, color: color),
    labelText: labelText,
    labelStyle: TextStyle(
       color: color
    ),
  );
}
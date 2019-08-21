import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {

  final bool obscureText;
  final bool enabled;

  final Color color;

  final double verticalPadding;
  final double horizontalPadding;

  final int maxLength;

  final void Function(String) onChanged;

  final IconData icon;

  final TextInputType keyboardType;

  final String text;
  final String labelText;
  
  TextInput({
    String key,
    this.icon,
    this.text,
    this.obscureText = false,
    this.enabled = true,
    this.maxLength,
    this.horizontalPadding = 0.0,
    this.verticalPadding = 0.0,
    this.color = Colors.grey,
    this.keyboardType = TextInputType.text,
    this.labelText = '',
    this.onChanged
  })
  : super(key: key != null ? Key(key) : null);

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
    child: TextField(
      key: key,
      controller: text != null ? TextEditingController(text: text) : null,
      obscureText: obscureText,
      enabled: enabled,
      onChanged: onChanged,
      maxLength: maxLength,
      style: TextStyle(
        color: Colors.blue
      ),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon != null ? Icon(icon, color: color,) : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 3.0
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 3.0
          )
        ),
        labelStyle: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
      keyboardType: keyboardType,
    ),
  );
}
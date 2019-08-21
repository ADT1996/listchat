import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final bool enabled;

  final Color color;
  final Color highlightedBorderColor;

  final double fontSize;
  final double verticalPadding;
  final double horizontalPadding;

  final Function onPressed;
  
  final IconData prefixIcon;
  final IconData suffixIcon;

  final String text;

  Button({
    Key key,
    this.onPressed,
    this.enabled = true,
    this.color = Colors.grey,
    this.highlightedBorderColor = Colors.grey,
    this.fontSize = 20,
    this.verticalPadding = 0.0,
    this.horizontalPadding = 0.0,
    this.prefixIcon,
    this.suffixIcon,
    this.text = '',
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      child: OutlineButton(
        onPressed: enabled ? () { FocusScope.of(context).requestFocus(new FocusNode()); if(onPressed != null) onPressed(); } : null,
        highlightedBorderColor: highlightedBorderColor,
        borderSide: BorderSide(
          color: color,
          width: 3.0,
          style: BorderStyle.solid,
        ),
        textColor: color,
        textTheme: ButtonTextTheme.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            prefixIcon != null ? Icon(prefixIcon, color: enabled ? color : null,) : Text(''),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ),
            suffixIcon != null ? Icon(suffixIcon, color: enabled ? color : null,) : Text('')
          ],
        )
      )
    );
  }
}
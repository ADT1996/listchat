import 'package:flutter/material.dart';

class ButtonWhithouFeedBack extends StatelessWidget {

  final bool enabled;

  final Color color;
  final Color backgroundColor;
  final Color borderColor;

  final double fontSize;
  final double verticalPadding;
  final double horizontalPadding;

  final Function onPressed;
  
  final IconData prefixIcon;
  final IconData suffixIcon;

  final String text;

  ButtonWhithouFeedBack({
    Key key,
    this.onPressed,
    this.enabled = true,
    this.color = Colors.grey,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
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
        highlightedBorderColor: borderColor,
        splashColor: backgroundColor,
        borderSide: BorderSide(
          color: borderColor,
          width: 1.0,
          style: BorderStyle.solid,
        ),
        textColor: color,
        textTheme: ButtonTextTheme.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            prefixIcon != null ? Icon(prefixIcon, color: enabled ? color : null,) : Text(''),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
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
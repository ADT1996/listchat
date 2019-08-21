import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {

  bool value;

  final Color color;

  final double horizontalPadding;
  final double verticalPadding;

  final Widget label;

  final MainAxisAlignment alignSelf;

  final void Function(bool) onChanged;

  CustomCheckbox({
    this.label,
    this.color = Colors.grey,
    this.horizontalPadding = 0.0,
    this.verticalPadding = 0.0,
    this.value = false,
    this.alignSelf = MainAxisAlignment.start,
    this.onChanged
  }) : super();

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();

}

class _CustomCheckboxState extends State<CustomCheckbox> {

  _CustomCheckboxController _controller;

  _CustomCheckboxState() : super() {
    _controller = _CustomCheckboxController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding, vertical: widget.verticalPadding),
    child: Row(
      mainAxisAlignment: widget.alignSelf,
      children: <Widget>[
        widget.label != null ? widget.label : Text(''),
        Checkbox(
          value: widget.value,
          onChanged: _controller.onChangedValue,
          activeColor: widget.color,
        )
      ],
    ),
  );
  }
}

class _CustomCheckboxController {

  bool value;

  bool _inited = false;

  _CustomCheckboxState _screen;

  _CustomCheckboxController(_CustomCheckboxState screen) {
    _screen = screen;
  }

  void onChangedValue(bool value) {

    FocusScope.of(_screen.context).requestFocus(new FocusNode());

    _screen.setState(() {
      _screen.widget.value = value;
    });

    if(_screen.widget.onChanged != null) {
      _screen.widget.onChanged(value);
    }
  }

}
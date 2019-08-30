import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:listchat/src/Components/Component.dart';
import 'package:listchat/src/Common/enum.dart';
import 'package:listchat/src/Model/Models.dart';

import './string.dart' as STRING;

class FormCreateRoom extends StatefulWidget {

  final void Function(Room) onCompleted;
  final void Function() onCancel;

  FormCreateRoom({
      @required this.onCompleted,
      this.onCancel
    }) : super();

  @override
  _FormCreateRoomState createState() => _FormCreateRoomState();
}

class _FormCreateRoomState extends State<FormCreateRoom> {

  _Controller _controller;

  _FormCreateRoomState() : super() {
    _controller = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextInput(
                labelText: STRING.ROOMNAME,
                onChanged: _controller.onChangedRoomName,
              ),
              DropdownButton<RoomMode>(
                isExpanded: true,
                onChanged: _controller.changeMode,
                value: _controller.modeRoom,
                items: <DropdownMenuItem<RoomMode>>[
                  DropdownMenuItem(
                    child: Text(STRING.PUBLIC),
                    value: RoomMode.PUBLIC,
                  ),
                  DropdownMenuItem(
                    child: Text(STRING.PRIVATE),
                    value: RoomMode.PRIVATE,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  OutlineButton.icon(
                    icon: Icon(Icons.cancel, color: Theme.of(context).buttonColor,),
                    label: Text(STRING.CANCEL),
                    borderSide: BorderSide(color: Colors.transparent),
                    color: Colors.transparent,
                    highlightColor: Colors.transparent,
                    highlightedBorderColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    textColor: Theme.of(context).buttonColor,
                    onPressed: _controller.onCancel,
                  ),
                  OutlineButton.icon(
                    icon: Icon(Icons.create, color: Theme.of(context).buttonColor,),
                    textColor: Theme.of(context).buttonColor,
                    borderSide: BorderSide(color: Theme.of(context).buttonColor),
                    color: Theme.of(context).buttonColor,
                    label: Text(STRING.CREATE),
                    onPressed: _controller.onCompleted,
                  )
                ],
              )
            ],
          );
  }
}

class _Controller {

  _FormCreateRoomState _screen;

  RoomMode modeRoom = RoomMode.PUBLIC;

  String roomName = '';

  _Controller(_FormCreateRoomState screen) {
    _screen = screen;
  }

  void changeMode(RoomMode mode) {
    _screen.setState(() {
      modeRoom = mode;
    });
  }

  void onChangedRoomName(String roomName) {
    this.roomName = roomName;
  }

  void onCompleted() {
    _screen.widget.onCompleted(Room(
      roomName: roomName,
      mode: modeRoom
    ));
  }

  void onCancel() {
    if(_screen.widget.onCancel != null) {
      _screen.widget.onCancel();
    }
  }
}
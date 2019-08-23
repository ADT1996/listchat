import 'package:flutter/material.dart';
import 'package:listchat/src/Model/Models.dart';
import 'package:listchat/src/Service/user.Service.dart';

import './main.dart';

class Controller {

  bool _inited = false;

  Room room = Room(
    id: '',
    bossId: '',
    bossName: '',
    roomName: '',
    members: <User>[],
    messages: <Message>[],
  );

  RoomchatState _screen;

  UserService _service;

  Controller(RoomchatState screen) {
    _screen = screen;
  }

  void initScreen() async {
    if(!_inited) {
      _inited = true;
      String roomId = ModalRoute.of(_screen.context).settings.arguments as String;
      _service = UserService(_screen.context);
      Room room = await _service.getRoom(roomId);
      if(room == null) {
        Navigator.of(_screen.context).pop(false);
        return;
      }
      _screen.setState(() {
        this.room = room;
      });
    }
  }

  

}
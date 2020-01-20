import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:listchat/src/Common/Common.dart';
import 'package:listchat/src/Common/enum.dart';
import 'package:listchat/src/Model/Models.dart';
import 'package:listchat/src/Service/user.Service.dart';
import 'package:listchat/src/redux/state.dart';

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
      mode: RoomMode.PUBLIC);

  RoomchatState _screen;

  UserService _service;

  String message = '';

  Controller(RoomchatState screen) {
    _screen = screen;
  }

  void _pushMessage(dynamic message) {
    if (message['roomId'].toString().compareTo(room.getId()) == 0) {
      _screen.setState(() {
        room.getMessages().add(Message(
            id: '',
            audio: message['message']['audio'],
            image: message['message']['image'],
            video: message['message']['video'],
            memberId: message['memberId'],
            message: message['message']['message']));
      });
    }
  }

  void _onMessageFromServer() {
    Socket.addEvent('message', _pushMessage);
  }

  Future<void> initScreen() async {
    if (!_inited) {
      _inited = true;
      String roomId =
          ModalRoute.of(_screen.context).settings.arguments as String;
      _service = UserService(_screen.context);
      Room room = await _service.getRoom(roomId);
      print(room);
      _onMessageFromServer();
      _screen.setState(() {
        this.room = room;
      });
    }
  }

  void onChangedMessage(String message) {
    this.message = message;
  }

  void sendMessage() {
    User user = Common.user;
    Socket.emit('message', {
      'roomId': room.getId(),
      'memberId': user.getId(),
      'message': {
        'image': null,
        'audio': null,
        'video': null,
        'message': message
      }
    });
    _screen.setState(() {
      message = '';
    });
  }

  void onMessageCompleted() {
    _screen.setState(() {
      message = message.trim();
    });
  }

  void dispose() {
    Socket.off('message', _pushMessage);
  }
}

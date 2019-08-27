import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:listchat/src/Common/Common.dart';
import 'package:listchat/src/Model/Models.dart';
import 'package:listchat/src/Navigator/StringScreen.dart';
import 'package:listchat/src/Service/base.Service.dart';
import 'package:listchat/src/Service/user.Service.dart';

import './main.dart';

class Controller {

  bool _inited = false;

  List<Room> rooms = <Room>[];

  HomeState _screen;

  UserService _service;

  Controller(HomeState screen) {
    _screen = screen;
  }

  void _onMessageFromServer() {
    Socket.addEvent('message', (data) {
      print(data);
    });
  }

  Future<void> initScreen() async {
    if(!_inited) {
      try {
        Common.user = ModalRoute.of(_screen.context).settings.arguments as User;
        Service.setToken(Common.user.getToken());
        _service = UserService(_screen.context);
        await Socket.connect();
        _onMessageFromServer();
        final rooms = await _service.getRooms();
        
        Socket.emit('joinRooms', rooms.map((room) => room.getId()).toList());
        _screen.setState(() {
          this.rooms = rooms;
        });
        _inited = true;
      } catch(ex) {
        print(ex);
      }
    }
    
  }

  void Function() getActionTap(String roomId) => () async {
    FocusScope.of(_screen.context).requestFocus(new FocusNode());
    dynamic result = await Navigator.of(_screen.context).pushNamed(ROOMCHAT , arguments: roomId);
    if(result != null && !result) {
      _inited = false;
      await initScreen();
    }
  };

  void close() {
    Socket.close();
  }

}
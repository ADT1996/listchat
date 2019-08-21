import 'package:flutter/material.dart';
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

  void initScreen(BuildContext context) async {
    if(!_inited) {
      try {
        Common.user = ModalRoute.of(context).settings.arguments as User;
        Service.setToken(Common.user.getToken());
        _service = UserService(context);
        Socket.connect();
        final rooms = await _service.getRooms();
        _screen.setState(() {
          this.rooms = rooms;
        });
        _inited = true;
      } catch(ex) {
        print(ex);
      }
    }
    
  }

  void Function() getActionTap( BuildContext context, String roomId) => () async {
    FocusScope.of(context).requestFocus(new FocusNode());
    dynamic result = await Navigator.of(context).pushNamed(ROOMCHAT , arguments: roomId);
    if(result != null && !result) {
      _inited = false;
    }
  };

  void close() {
    Socket.close();
  }

}
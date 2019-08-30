import 'package:flutter/material.dart';

import 'package:listchat/src/Common/Common.dart';
import 'package:listchat/src/Model/Models.dart';
import 'package:listchat/src/Navigator/StringScreen.dart';
import 'package:listchat/src/Service/base.Service.dart';
import 'package:listchat/src/Service/user.Service.dart';

import './main.dart';
import './string.dart' as STRING;

class Controller {

  bool _inited = false;
  bool showAll = true;

  int modeRoom = 0;

  String _currentRoomId = '';

  String _roomName = '';

  List<Room> rooms = <Room>[];

  List<Room> viewRooms = <Room>[];

  HomeState _screen;

  UserService _service;

  Controller(HomeState screen) {
    _screen = screen;
  }

  void _onMessageFromServer() {
    Socket.addEvent('message', (data) {
      print('Home');
      print(data['roomId']);
      if(data['roomId'].toString().compareTo(_currentRoomId) == 0) {
        print(data);
      }
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
        this.rooms = rooms;
        Socket.emit('joinRooms', rooms.map((room) => room.getId()).toList());
        _screen.setState(() {
          viewRooms = rooms;
        });
        _inited = true;
      } catch(ex) {
        print(ex);
      }
    }
    
  }

  void _navigateToRoom(String roomId) async {
    FocusScope.of(_screen.context).requestFocus(new FocusNode());
    _currentRoomId = roomId;
    dynamic result = await Navigator.of(_screen.context).pushNamed(ROOMCHAT , arguments: roomId);
    if(result != null && !result) {
      _inited = false;
      await initScreen();
    }
  }

  void Function() getActionTap(String roomId) => () async {
    _navigateToRoom(roomId);
  };

  void close() {
    Socket.close();
  }

  void searchRoom(String roomName) {
    List<Room> roomSearch = <Room>[];
    _roomName = roomName;
    rooms.forEach((Room room) {
      if(_roomName.isEmpty || room.getRoomName().contains(roomName)) {
        roomSearch.add(room);
      }
    });
    _screen.setState((){
      viewRooms = roomSearch;
    });
  }

  void searchRoomButton() {
    List<Room> roomSearch = <Room>[];
    rooms.forEach((Room room) {
      if(room.getRoomName().contains(_roomName)) {
        roomSearch.add(room);
      }
    });
    _screen.setState((){
      viewRooms = roomSearch;
    });
  }

  void _showRooms() {
    List<Room> viewRooms = <Room>[];
    bool showAll = !this.showAll;
    rooms.forEach((room) {
      if( _roomName.isEmpty || room.getRoomName().contains(_roomName)) {
        Room roomSearch = room.getMembers().firstWhere((User member){
          return member.getId().compareTo(Common.user.getId()) == 0;
        }) as Room;
        if(roomSearch != null) {
          viewRooms.add(roomSearch);
        }
      }
    });
    _screen.setState((){
      this.showAll = showAll;
      this.viewRooms = viewRooms;
    });
  }

  void onTapMenu(String value) {
    switch(value) {
      case STRING.ADDROOM:
        _screen.showPopup();
        break;
      case STRING.JOINEDONLY:
        _showRooms();
        break;
      default:
        break;
    }
  }

  void createRoom(dynamic room) {
    
  }
}
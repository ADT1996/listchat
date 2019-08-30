import 'package:adhara_socket_io/adhara_socket_io.dart' as IO;
import 'package:flutter/cupertino.dart';

import 'package:listchat/src/Common/Common.dart';
import 'package:listchat/src/API/user.API.dart';
import 'package:listchat/src/Common/enum.dart';
import 'package:listchat/src/Config/config.dart';
import 'package:listchat/src/Model/Models.dart';
import 'package:listchat/src/Service/base.Service.dart';
import 'package:listchat/src/Service/service.Common.dart';

class Socket {

  static IO.SocketIO _socket;
  
  static bool _conntected = false;

  static Future<void> connect() async {
    try {
      if(!_conntected) {
        _socket = await IO.SocketIOManager().createInstance(new IO.SocketOptions('$HOST/'));
        _socket.onDisconnect((data) {
          print('Disconnected');
        });

        _socket.connect();

        _conntected = true;
      }
    } catch(ex) {
      print(ex);
    }
  }

  static void addEvent(String event, void Function(dynamic) action) {
    _socket.on(event, action);
  }

  static void emit(String event, dynamic data) {
    _socket.emit(event, [data]);
  }

  static void close() async {
    if(_conntected) {
      await IO.SocketIOManager().clearInstance(_socket);
      // _socket.emitWithAck('close', null);
      _conntected = false;
    }
  }
  static void off(String eventName, Function fn) {
    _socket.off(eventName, fn);
  }

}

class UserService extends Service {

  UserAPI _userApi;

  UserService(BuildContext context) : super() {
    _userApi = UserAPI(context);
  }

  Future<List<Room>> getRooms() async {
    final room = await _userApi.get('/room/getRooms');

    if(room != null) {
      final listRooms = Common.objectToRooms(room);
      return <Room>[...listRooms];
    }

    return <Room>[];
  }

  Future<Room> getRoom(String roomId) async {
    final data = await _userApi.get('/room/getRoom/' + roomId);
    
    if(data != null) {
      return Common.objectToRoom(data);
    }

    return null;
  }

  Future<void> createRoom(Room room) async {
    final data = await _userApi.post('/room/create', {
      Parameter.ROOMNAME: room.getRoomName(),
      Parameter.MODEROOM: room.getMode() == RoomMode.PUBLIC ? 0.toString() : 1.toString(),
    });

    if(data != null) {
      return Common.objectToRoom(data);
    }
    return null;
  }
}
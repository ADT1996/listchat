import 'package:adhara_socket_io/adhara_socket_io.dart' as IO;
import 'package:flutter/cupertino.dart';

import 'package:listchat/src/Common/Common.dart';
import 'package:listchat/src/API/user.API.dart';
import 'package:listchat/src/Config/config.dart';
import 'package:listchat/src/Model/Models.dart';
import 'package:listchat/src/Service/base.Service.dart';

class Socket {

  static IO.SocketIO _socket;
  
  static bool _conntected = false;

  static void connect() async {
    try {
      if(!_conntected) {
        _socket = await IO.SocketIOManager().createInstance(new IO.SocketOptions('http://$HOST/'));

        _socket.onDisconnect((data) {
          print('Disconnected');
        });

        _conntected = true;
      }
    } catch(ex) {
      print(ex);
    }
  }

  static void addEvent(String event, void Function(dynamic) action) {
    // _socket.once(event, action);
  }

  static void close() async {
    if(_conntected) {
      await IO.SocketIOManager().clearInstance(_socket);
      // _socket.emitWithAck('close', null);
      _conntected = false;
    }
  }
}

class UserService extends Service {

  UserAPI _userApi;

  UserService(BuildContext context) : super() {
    _userApi = UserAPI(context);
  }

  Future<List<Room>> getRooms() async {
    final room = await _userApi.get('/getRooms');

    if(room != null) {
      final listRooms = Common.objectToRooms(room);
      return <Room>[...listRooms];
    }

    return <Room>[];
  }

  Future<Room> getRoom(String roomId) async {
    final data = await _userApi.get('/getRoom/' + roomId);
    
    if(data != null) {
      return Common.objectToRoom(data);
    }

    return null;
  }
}
import 'package:flutter/foundation.dart';
import 'package:listchat/src/Common/enum.dart';

import './Models.dart';
import './Model.dart';

class Room extends Model {
  
  String _id;
  String _roomName;
  String _bossName;
  String _bossId;
  List<User> _members;
  List<Message> _messages;
  RoomMode _mode;

  Room({
    @required String id,
    @required String roomName,
    @required String bossName,
    @required String bossId,
    @required List<User> members,
    @required RoomMode mode,
    List<Message> messages
  }) {
    _roomName = roomName;
    _bossId = bossId;
    _bossName = bossName;
    _members = members;
    _id = id;
    _messages = messages;
    _mode = mode;
  }

  String getRoomName() => _roomName;
  String getBossName() => _bossName;
  String getBossId() => _bossId;
  String getId() => _id;
  RoomMode getMode() => _mode;
  List<User> getMembers() => _members;
  List<Message> getMessages() => _messages;
}
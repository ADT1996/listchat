import 'package:flutter/foundation.dart';

import './Models.dart';
import './Model.dart';

class Room extends Model {
  
  String _id;
  String _roomName;
  String _bossName;
  String _bossId;
  List<User> _members;
  List<Message> _messages;

  Room({
    @required String id,
    @required String roomName,
    @required String bossName,
    @required String bossId,
    @required List<User> members,
    List<Message> messages
  }) {
    _roomName = roomName;
    _bossId = bossId;
    _bossName = bossName;
    _members = members;
    _id = id;
    _messages = messages;
  }

  String getRoomName() => _roomName;
  String getBossName() => _bossName;
  String getBossId() => _bossId;
  String getId() => _id;
  List<User> getMembers() => _members;
  List<Message> getMessages() => _messages;
}
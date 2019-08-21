import 'package:listchat/src/Model/Model.dart';

class Message extends Model {
  String _id;
  String _memberId;
  String _image;
  String _audio;
  String _video;
  String _message;

  Message({
    String id,
    String memberId,
    String image,
    String audio,
    String video,
    String message
  }) {
    _id = id;
    _memberId = memberId;
    _image = image;
    _audio = audio;
    _video = video;
    _message = message;
  }

  String getId() => _id;
  String getMemberId() => _memberId;
  String getImage() => _image;
  String getAudio() => _audio;
  String getVideo() => _video;
  String getMessage() => _message;
}
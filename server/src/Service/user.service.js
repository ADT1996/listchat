const json = require('../asset/data.json');

class UserService {
     getRooms(callback) {
          callback(json.rooms);
     }

     getRoom(roomId, callback) {
          const room = json.roomMessage.find(function(room) {
               return room.id === roomId;
          });

          callback(room);
     }
}

module.exports = UserService;
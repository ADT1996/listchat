module.exports = function(service, packages) {
  
  const route = packages.express.Router();
  const roomService = service.room;

  route.get('/getRooms', async function(req, res) {
    const rooms = await roomService.getMulti();
    if(!rooms) {
      rooms = [];
    }
    res.status(200).jsonp(rooms);
  });

  route.get('/getroom/:roomId', function(req, res) {
    const roomId = req.params.roomId;
    const room = roomService.getSinglebyId(roomId);
    if(room) {
      res.status(200).jsonp(null);
      return;
    }
    if(!room.members) {
      room.members = [];
    }
    if(!room.messages) {
      room.messages = [];
    }
    res.status(200).jsonp(room);
  });

  return route;
}
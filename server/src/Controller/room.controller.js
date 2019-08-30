module.exports = function(service, packages) {
  
     const route = packages.express.Router();
     const roomService = service.room;
   
     route.get('/getRooms', async function(req, res) {
       const rooms = await roomService.getMulti(req.headers.user._id);
       if(!rooms) {
         rooms = [];
       }
       res.status(200).jsonp(rooms);
     });
   
     route.get('/getRoom/:roomId', async function(req, res) {
       try{

          const roomId = req.params.roomId;
          const room = await roomService.getSingleById(roomId);
          if(!room) {
            res.status(200).jsonp(null);
            return;
          }

          if(!room.members) {
            room.members = [];
          }
          if(!room.messages) {
            room.messages = [];
          }

          console.log(room);

          res.status(200).jsonp(room);

       } catch(ex) {
            console.error(ex);
            res.status(500).send();
       }
     });

     route.post('/create', async function(req, res) {
          const user = req.headers.user;
          const room = req.body;
          const roomInsert = {
               roomName: room.roomName,
               mode: parseInt(room.mode),
          };

          roomInsert.bossId = user._id;
          roomInsert.members = [{
               memberId: user._id,
               status: 1
          }];
          const roomInserted = await roomService.insertSingle(roomInsert);
          roomInserted.bossName = user.firstName;
          roomInserted.members = [];
          res.status(200).jsonp(roomInserted);
     });
   
     return route;
   }
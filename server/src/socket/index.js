module.exports = function(server) {

     console.log('setting socket');

     const io = require('socket.io')(server);

     io.on('connection', function(socket) {
          console.log('connection');
          socket.on('disconnect', function(){
               console.log('disconnect');
		socket.disconnect();
          });

	     socket.on('message', function(data) {
               console.log(data);
               io.to(data['roomId']).emit('message',data);
          });
          
          socket.on('joinRooms', function(rooms){
               console.log(rooms);
               rooms.forEach(function(room) {
                    socket.join(room);
               });
          });

     });

     console.log('completed setting');
//     io.on('connect', function(socket) {
//          console.log('conntect');
//     });
}

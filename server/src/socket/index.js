module.exports = function(io) {

     console.log('setting socket');

     io.on('connection', function(socket) {
          console.log('connection');
          socket.on('disconnect', function(){
               console.log('disconnect');
		socket.disconnect();
          });

	socket.on('message', function(data) {
		console.log(data);
	});

     });

     console.log('completed setting');
//     io.on('connect', function(socket) {
//          console.log('conntect');
//     });
}

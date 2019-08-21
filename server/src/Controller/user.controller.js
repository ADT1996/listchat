const route = require('express').Router();
const UserService = require('../Service/user.service');

const service = new UserService();


route.get('/getRooms', function(req, res) {
	service.getRooms(function(rooms) {
		res.status(200).jsonp(rooms);
	});
});

route.get('/getroom/:roomId', function(req, res) {
	const roomId = req.params.roomId;
	service.getRoom(roomId, function(room) {
		if(room) {
			res.status(200).jsonp(room);
			return;
		}
		res.status(200).jsonp(null);
	});
});

module.exports = route;

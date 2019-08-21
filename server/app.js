const express = require('express');
const app = express();
const server = require('http').createServer(app);
const bodyParser = require('body-parser');
const cors = require('cors');
const io = require('socket.io')(server);
const socket = require('./src/socket');
const json = require('./src/asset/data.json');
const ip = require('ip');

socket(io);

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded());

app.use('/nonuser', require('./src/Controller/nonUser.controller'));
app.use('/user', function(req, res, next) {
	const token = req.headers.authorization;
	const user = json.users.find(user => token === user.token);

	if(user) {
		req.headers.user = user;
		next();
	}

	res.status(401).send();
});
app.use('/user', require('./src/Controller/user.controller'));
const port = process.env.PORT || 3000;

server.listen(port, function() {
	console.log(`Server running on server`);
	console.log(`${ip.address('public','ipv4')}:${port}`);
	console.log(`${ip.address('public','ipv6')}:${port}`);
});

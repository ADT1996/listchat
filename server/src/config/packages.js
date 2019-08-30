const express = require('express');
const app = express();
module.exports = {
     config: require('./config.json'),
     express: express,
     app: app,
     server: require('http').createServer(app),
     bodyParser: require('body-parser'),
     cors: require('cors'),
     ip: require('ip'),
     mongodb: require('mongodb'),
     aesjs: require('aes-js'),
     common: require('../common'),
     socketIO: require('socket.io'),
     controller: {
          nonuser: require('../Controller/non-User.controller'),
          user: require('../Controller/user.controller'),
          room: require('../Controller/room.controller'),
          run: require('../Controller'),
     },
     service: {
          base: require('../Service/base.service'),
          services: require('../Service/index'),
     },
     repository: {
          base: require('../Repository/base.repo'),
          repositoroes: require('../Repository/index'),
     }
}
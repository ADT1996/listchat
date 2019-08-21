const Service = require('./base.service');
const aesjs = require('aes-js');
const config = require('../config/config');

class nonUserService extends Service {
     login(email, password, callback) {
          var userReturn = null;
          const passByte = aesjs.utils.utf8.toBytes(password);
          const aesCtr = new aesjs.ModeOfOperation.ctr(config.key, new aesjs.Counter(5));
          const byteEncrypt = aesCtr.encrypt(passByte);
          const passEncrypt = aesjs.utils.hex.fromBytes(byteEncrypt);

          const user = Service.getData('users').find(user => user.email === email && user.password === passEncrypt);
          
          if(user) {
               userReturn = {...user};
               userReturn.password = undefined;
          }
          
          callback(userReturn);
     }
}

module.exports = nonUserService;

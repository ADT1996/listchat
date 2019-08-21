const json = require('../asset/data.json');

class Service {
     static getData(data) {
          return json[data];
     }
}

module.exports = Service;
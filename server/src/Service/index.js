module.exports = function(repo, packages) {
     return {
          user: require('./user.service')(repo, packages),
          room: require('./room.service')(repo, packages),
          token: require('./token.service')(repo, packages),
     }
}
module.exports = function(db, packages) {
     return {
          room: require('./room.repo')(db, packages),
          message: require('./message.repo')(db, packages),
          user: require('./user.repo')(db, packages),
          token: require('./token.repo')(db, packages),
     }
}
module.exports = function(db, packages) {
     class RoomRepo extends packages.repository.base {
          constructor(db) {
               super(db, 'room');
          }
     }

     return new RoomRepo(db);
}
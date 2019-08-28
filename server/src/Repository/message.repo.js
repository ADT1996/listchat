module.exports = function(db, packages) {
     class MessageRepo extends packages.repository.base {
          constructor(db) {
               super(db, 'message');
          }
     }

     return new MessageRepo(db);
}
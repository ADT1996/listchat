module.exports = function(db, packages) {
     class TokenRepo extends packages.repository.base {
          constructor(db) {
               super(db, 'token', packages);
          }
     }

     return new TokenRepo(db);
}
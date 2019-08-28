module.exports = function(repo, packages) {
     class TokenService extends packages.service.base {
          constructor(repo) {
               super(repo, 'token');
          }
     }

     return new TokenService(repo);
}
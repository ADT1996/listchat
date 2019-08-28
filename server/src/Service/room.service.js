module.exports = function(repo, packages) {
     class RoomService extends packages.service.base {
          constructor(repo) {
               super(repo, 'room');
          }
     }

     return new RoomService(repo);
}
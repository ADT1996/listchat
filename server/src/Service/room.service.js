module.exports = function(repo, packages) {

     const userRepo = repo.user;
     const roomRepo = repo.room;

     class RoomService extends packages.service.base {

          constructor(repo) {
               super(repo, 'room');
          }

          async getMulti(userId) {
               const rooms = await roomRepo.getMulti({
                    $or: [
                         {
                              mode: 0
                         },
                         {
                              mode: 1,
                              members: { $all: [{ memberId: userId, status: 1 }] }
                         },
                    ]
               });
               
               if(!rooms) return null;

               for(let i = 0; i < rooms.length; i++) {
                    const Ids = rooms[i].members.map(function(member) {
                         return member.memberId;
                    });
                    const members = await userRepo.getMulti({
                         _id: { $in: Ids }
                    });

                    members.forEach(member => {
                         member.password = undefined;
                    });

                    rooms[i].members = members;

                    rooms[i].bossName = members.find(function(member) {
                         return member._id.toString() === rooms[i].bossId.toString();
                    }).firstName;
               }

               return rooms;
          }
     }

     return new RoomService(repo);
}
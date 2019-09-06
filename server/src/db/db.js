module.exports = async function(packages, fn) {
     const mongoClient = packages.mongodb.MongoClient;
     const dbConnectionString = packages.config.dbConnectionString;

     const mongo = new mongoClient(dbConnectionString, { useNewUrlParser: true, useUnifiedTopology: true });
     const mongodb = await mongo.connect(function(err, mongodb){
          if(err) {
               console.error('Starting is fail.', err);
               throw err;
          }
          fn(mongodb);
          return mongodb;
     });
     return mongodb;
}
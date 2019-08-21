const route = require('express').Router();
const NonUserService = require('../Service/non-User.service');

const service = new NonUserService();

route.post('/login', function(req, res) {
     const email = req.body.email;
     const password = req.body.password;

     service.login(email, password,
          function(user) {
               if(user) {
                    res.status(200).jsonp(user);
                    return;
               }
               res.status(401).send();
          }
     );
	
});

route.post('/signup', function(req, res) {
     const email = req.body.email;
     const password = req.body.password;
     const firstName = req.body.firstName;
     const lastName = req.body.lastName;
     const birthday = req.body.birthday;

     if(
          !email || !email.length || !password || !password.length ||
          !firstName || !firstName.length || !lastName || !lastName.length ||
          !birthday || birthday.length != 10
     ) {
          res.status(200).jsonp({
               result: 'fail'
          });
          return;
     }

     res.status(200).jsonp({
          result: 'OK'
     });

});

module.exports = route;

module.exports = function(service, packages) {
  const route = packages.express.Router();

  route.post('/login', async function(req, res) {
    const email = req.body.email;
    const password = req.body.password;
    const user = await service.user.login(email, password);
    if(user) {
      res.status(200).jsonp(user);
      return;
    }
    res.status(401).send();
  });
  
  route.post('/signup', async function(req, res) {
    const email = req.body.email;
    const password = req.body.password;
    const firstName = req.body.firstName;
    const lastName = req.body.lastName;
    const birthday = req.body.birthday;

    const data = await service.user.signUp({email: email, password: password, firstName: firstName, lastName: lastName, birthday: birthday});

    if(data === 'REGISTED') {
      res.status(200).jsonp({result: 'OK'});
      return;
    }

    res.status(200).jsonp({
      result: 'FAIL'
    });

  });
  
  return route;
}
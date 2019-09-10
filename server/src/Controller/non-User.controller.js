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
  
  route.get('/getcertkey', function(req, res) {
    console.log('getcertkey');

    const key = packages.config.key;
    const iv = packages.config.iv;
    const aesjs = packages.aesjs;

    const certKey = packages.common.generateCertKey();
    packages.certkes[certKey] = Date.now();
    res.status(200).jsonp({ key: certKey });

    const certKeyByte = aesjs.utils.utf8.toBytes(certKey);
    var aesCbc = new aesjs.ModeOfOperation.cbc(key, iv);
    var decryptedBytes = aesCbc.encrypt(certKeyByte);
    var decryptedText = aesjs.utils.hex.fromBytes(decryptedBytes);
    packages.certkes[decryptedText.substring(0, 255)] = Date.now();

  });

  route.post('/loginByFirebase', function(req, res) {
    try{

      const requestKey = req.headers.certkey;
      const genTime = packages.certkes[requestKey.substring(0, 255)];

      if(genTime && Date.now() - genTime <= 600000) {
        const user = service.user.login3thorgizaration(req.body);
        res.status(200).jsonp({
          result: 'OK',
          user: user
        });
      } else {
        res.status(200).jsonp({result: 'FAIL'});
      }
      delete packages.certkes[decryptedText];
    } catch {
      res.status(500).send();
    }
  });

  return route;
}
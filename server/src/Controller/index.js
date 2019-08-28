module.exports = function(service, packages) {
     
     const app = packages.app;
     const nonuserController = packages.controller.nonuser;
     const userController = packages.controller.user;

     app.use('/user', async function(req, res, next) {
          const token =  req.headers.authorization;
		const userToken = await service.token.getSingle({token: token});

		if(!userToken) {
			res.status(401).send();
			return;
		}
	
		const user = await service.user.getSingle({_id: userToken.userId});

		if(user) {
			req.headers.user = user;
			next();
			return;
		}
	
		res.status(401).send();
     });

     app.use('/nonuser',nonuserController(service, packages));
     app.use('/user', userController(service, packages));

     return app;
}
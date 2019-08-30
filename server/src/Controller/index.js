module.exports = function(service, packages) {
     
     const app = packages.app;
     const nonuserController = packages.controller.nonuser;
	const userController = packages.controller.user;
	const roomController = packages.controller.room;

	app.use(function(req, res, next) {
		if( req.method === 'POST' && req.body) {
			req.body = JSON.parse(req.body);
		}
		next();
	})

     app.use('/auth', async function(req, res, next) {
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
     app.use('/auth/user', userController(service, packages));
	app.use('/auth/room', roomController(service, packages));

     return app;
}
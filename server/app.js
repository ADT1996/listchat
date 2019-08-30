const packages = require('./src/config/packages');

require('./src/db/db')(packages, function(mongodb) {

	const app = packages.app;
	const ip = packages.ip;
	const cors = packages.cors;
	const bodyParser = packages.bodyParser;
	const server = packages.server;
	const port = process.env.PORT || 3000;

	const repositories = packages.repository.repositoroes(mongodb, packages);
	const service = packages.service.services(repositories, packages);
	
	require('./src/socket')(service, packages);
	
	app.use(cors());
	app.use(bodyParser.text());
	app.use(bodyParser.json());
	app.use(bodyParser.urlencoded());

	packages.controller.run(service, packages);
	
	server.listen(port, function() {
		console.log(`Server running on server`);
		console.log(`${ip.address('public','ipv4')}:${port}`);
		console.log(`${ip.address('public','ipv6')}:${port}`);
	});

});


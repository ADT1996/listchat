module.exports = function(repo, packages) {

	const aesjs = packages.aesjs;
	const config = packages.config;
	const userRepo = repo.user;
	const tokenRepo = repo.token;
	const common = packages.common;

	class UserService extends packages.service.base {

		constructor(repo) {
			super(repo, 'user');
		}

		async login(email, password) {
			var userReturn = null;
			const passByte = aesjs.utils.utf8.toBytes(password);
			const aesCtr = new aesjs.ModeOfOperation.ctr(config.key, new aesjs.Counter(5));
			const byteEncrypt = aesCtr.encrypt(passByte);
			const passEncrypt = aesjs.utils.hex.fromBytes(byteEncrypt);
		
			const user = await userRepo.getByEmailPassword(email, passEncrypt);
		
			if(user) {
				userReturn = {...user};
				userReturn.password = undefined;
				userReturn.token = common.generateToken();
				await tokenRepo.insertSingle({token: userReturn.token, userId: userReturn._id});
			}
		
			return userReturn;
		}
		
		async signUp(user) {
			const checkedUser = await userRepo.getSingle({email: user.email});

			if(checkedUser) {
				return 'EXISTED';
			}

			var userReturn = null;
			const passByte = aesjs.utils.utf8.toBytes(user.password);
			const aesCtr = new aesjs.ModeOfOperation.ctr(config.key, new aesjs.Counter(5));
			const byteEncrypt = aesCtr.encrypt(passByte);
			const passEncrypt = aesjs.utils.hex.fromBytes(byteEncrypt);
			user.password = passEncrypt;
			await userRepo.insertSingle(user);
			return "REGISTED";
		}
	}

  return new UserService(repo);
}
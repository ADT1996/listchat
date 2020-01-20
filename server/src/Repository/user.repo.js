module.exports = function(db, packages) {
  class UserRepo extends packages.repository.base {
    constructor(db) {
      super(db, "user", packages);
    }

    async getByEmailPassword(email, password) {
      const user = await this.getSingle({ email: email, password: password });
      return user;
    }
  }

  return new UserRepo(db);
};

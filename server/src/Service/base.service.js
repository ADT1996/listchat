class Service {

     constructor(repo, repoName) {
          this.repo = repo;
          this.repoName = repoName;
     }

     async getSingleById(id) {
		const data = await this.repo[this.repoName].getSingleById(id);
		return data;
	}
	
	async getMulti(filter) {
		const array = await this.repo[this.repoName].getMulti(filter || {});
		return array;
	}

	async getSingle(filter) {
		const data = await this.repo[this.repoName].getSingle(filter || {});
		return data;
	}

	async insertSingle(data) {
		const dataReturn = await this.repo[this.repoName].insertSingle(data);
		return dataReturn;
	}

	async insertMulti(data) {
		const dataReturn = [...data];
		await this.repo[this.repoName].insertMulti(data);
		return dataReturn;
	}
}

module.exports = Service;
class BaseRepo {
	constructor(db, collectionName) {
		this.db = db;
		this.collectionName = collectionName;
	}

	async getSingleById(id) {
		const data = await this.db.db().collection(this.collectionName).findOne({ _id: id })
			.then(
				function(data) {
					return data;
				}
			).catch(
				function(err) {
					throw err;
				}
			);
		return data;
	}
	
	async getMulti(filter) {
		const array = await this.db.db().collection(this.collectionName).find(filter || {})
			.toArray()
				.then(
					function(data) {
						return data;
					}
				).catch(
					function(err) {
						throw err;
					}
				);
		return array;
	}

	async getSingle(filter) {
		const data = await this.db.db().collection(this.collectionName).findOne(filter || {})
			.then(
				function(data) {
					return data;
				}
			).catch(
				function(err) {
					throw err;
				}
			);
		return data;
	}

	async insertSingle(data) {
		const dataReturn = {...data};
		await this.db.db().collection(this.collectionName).insertOne(data).then(
			function(inserted) {
				dataReturn._id = inserted.insertedId;
			}
		);
		return dataReturn;
	}

	async insertMulti(data) {
		const dataReturn = [...data];
		await this.db.db().collection(this.collectionName).insert(data).then(
			function(inserted) {
				dataReturn._id = insertedId;
			}
		);
		return dataReturn;
	}

}

module.exports = BaseRepo;
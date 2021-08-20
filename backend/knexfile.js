

module.exports = {
	client: 'mysql',
	connection: {
        host : '127.0.0.1',
        port: 3306,
        database: 'processo_seletivo_flutter',
        user: 'root',
        password: 'Omgksyhd'
    },
	pool: {
		min: 2,
		max: 10
	},
	migrations: {
		tableName: 'knex_migrations'
	},

};

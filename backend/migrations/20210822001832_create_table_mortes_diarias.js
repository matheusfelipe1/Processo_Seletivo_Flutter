
exports.up = function(knex, Promise) {
  return knex.schema.createTable('dados_do_mes', table => {
      table.increments('id')
      table.integer('totalDeaths');
      table.integer('biggerNewDeaths');
      table.dateTime('Date');
      table.integer('totalConfirmed');
      table.integer('biggerNewCases');
      table.string('latitude').notNull()
      table.string('longitude').notNull() 
  })
};

exports.down = function(knex, Promise) {
   return knex.schema.dropTable('dados_do_mes')
};

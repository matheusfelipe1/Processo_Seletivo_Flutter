
exports.up = function(knex, Promise) {
  return knex.schema.createTable('dados_do_mes', table => {
      table.increments('id')
      table.integer('Deaths');
      table.dateTime('Date');
      table.string('DateApi');
      table.integer('Confirmed');
      table.string('latitude').notNull()
      table.string('longitude').notNull() 
  })
};

exports.down = function(knex, Promise) {
   return knex.schema.dropTable('dados_do_mes')
};

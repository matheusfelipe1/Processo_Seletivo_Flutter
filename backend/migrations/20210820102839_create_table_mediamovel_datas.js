
exports.up = function(knex, Promise) {
  return knex.schema.createTable('media_movel_datas_respectivas', table => {
      table.increments('id').primary()
      table.integer('moving_average').notNull()
      table.string('Date').unique()
      table.integer('totalDeath').notNull()
      table.integer('totalCasesConfirmed')
  })
};

exports.down = function(knex, Promise) {
    return knex.schema.dropTable('media_movel_datas_respectivas')
};


exports.up = function(knex, Promise) {
  return knex.schema.createTable('media_movel_datas_respectivas', table => {
      table.increments('id').primary()
      table.string('moving_average').notNull()
      table.string('Date').unique()
      table.string('totalDeath').notNull()
      table.string('totalRecovered')
      table.string('totalCasesConfirmed')
  })
};

exports.down = function(knex, Promise) {
    return knex.schema.dropTable('media_movel_datas_respectivas')
};

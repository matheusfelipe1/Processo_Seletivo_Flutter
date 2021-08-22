
exports.up = function(knex, Promise) {
    return knex.schema.createTable('dados_medias_solicitadas', table => {
        table.increments('ID').primary()
        table.string('Country')
        table.integer('newCases')
        table.integer('newDeaths')
        table.integer('Confirmed')
        table.integer('Deaths')
        table.string('Date')
    })
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable('dados_medias_solicitadas')
};

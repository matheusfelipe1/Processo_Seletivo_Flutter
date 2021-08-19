
exports.up = function(knex, Promise) {
    return knex.schema.createTable('covidbrasil', table => {
        table.string('ID').primary()
        table.string('Country')
        table.string('CountryCode')
        table.string('Province')
        table.string('City')
        table.string('CityCode')
        table.string('Lat')
        table.string('Lon')
        table.integer('Confirmed')
        table.integer('Deaths')
        table.integer('Recovered')
        table.integer('Active')
        table.string('Date')
    })
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable('covidbrasil')
};

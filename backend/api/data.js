const axios = require('axios');
const { connection } = require('../knexfile');
const mysql = require('mysql');
module.exports = app => {
    var connections = mysql.createConnection(connection)
    const mostraTodos = async (req, res, next) => {
        
        await axios.get('https://api.covid19api.com/country/brazil?from=2021-02-01T00:00:00Z&to=2021-08-19T00:00:00Z')
            .then(resp => {
              
                    for (var i = 0; i <= resp.data.length; i++)  {
                    const validate =  app.db('covidbrasil').where({'ID': resp.data[i]['ID']}).first()
                    if (validate == true) {
                        return
                    }
                        app.db('covidbrasil')
                        .insert(resp.data[i])
                        .then(() => res.send('deu certo'))
                        .catch(err => res.send('erro!'))
                    }
               

            })

    }  

    const data = async (req, res) => {
        var valorData = {...req.body}
                var data = `${valorData.data1}T00:00:00Z`
                var data2 = `${valorData.data2}T00:00:00Z`
                connections.query( 'SELECT * FROM covidbrasil WHERE Date >= "'+data+'" AND Date <= "'+data2+'" ORDER BY Date', function (error, results, fields) {
                    if (error) res.send(error)
                    res.send(results)
                  });
              console.log('Connected!:)');
    }       

    return {mostraTodos, data}
}
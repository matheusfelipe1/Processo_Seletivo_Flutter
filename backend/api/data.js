const axios = require('axios');
const { connection } = require('../knexfile');
const mysql = require('mysql');
module.exports = app => {
    var connections = mysql.createConnection(connection)
    const mostraTodos = async (req, res, next) => {
        await connections.query('TRUNCATE TABLE covidbrasil', function (error, results) {
            if(error) return res.send(error)
        })
        await axios.get('https://api.covid19api.com/country/brazil?from=2021-02-01T00:00:00Z&to=2021-08-19T00:00:00Z')
            .then(resposta => {                
                        for ( var i in resposta.data) {
                            app.db('covidbrasil')
                            .insert(resposta.data[i])
                            .then(() => res.send())
                            .catch(err => res.send(err))
                    }
            })

    }  

    const mediaDeMortes = async (req, res) => {
                var valorData = {...req.body}
                var data = `${valorData.data1}T00:00:00Z` //esta é a data principal, a outra é apenas um calculo de 14 dias antes para fazer a media movel
                var data2 = `${valorData.data2}T00:00:00Z`
                connections.query('TRUNCATE TABLE dados_medias_solicitadas', function (error, results) {
                    if(error) return res.send(error)
                })
                connections.query( 'SELECT * FROM covidbrasil WHERE Date >= "'+ data +'" AND Date <= "'+ data2 +'" ORDER BY Date', 
                    function (error, results)  {
                        if (error) return res.send(error)
                        let totalMortes = 0
                        let totalRecuperadas = 0
                        let totalCasosConfirmados = 0
                       
                        results.map((dados, index) => {
                            totalMortes +=  dados['Deaths']
                            totalRecuperadas += dados['Recovered']
                            totalCasosConfirmados += dados['Confirmed']
                             app.db('dados_medias_solicitadas')
                                    .insert(dados)
                                    .then(() => res.json())
                                    .catch(err => res.json('Erro!'))
                                    
                        })
                       
                        let media = totalMortes / 14                        
                        connections.query(
                            "INSERT INTO media_movel_datas_respectivas (moving_average, Date, totalDeath, totalRecovered, totalCasesConfirmed) VALUES (?, ?, ?, ?, ?)",
                            [media, data, totalMortes, totalRecuperadas, totalCasosConfirmados],
                            function(err, results, fields){
                                if (error) return res.send(error);
                            }
                        ) 
                        res.json(media)
                    }
                );

    } 

    const buscarDadosDasMedias = async (req, res) => {
        var valorData = {...req.body}
        var data = `${valorData.data1}T00:00:00Z`
        let somatorioMortes = 0
        let somatorioCasosConfirmados = 0
        let somatorioRecuperados = 0
        await connections.query('SELECT * FROM media_movel_datas_respectivas', function (error, results) {
            if(error) return res.send(error)
            results.map((dados, index) => {
                somatorioMortes = eval(`${dados['totalDeath']}+${somatorioMortes}`)
                somatorioRecuperados = eval(`${dados['totalRecovered']}+${somatorioRecuperados}`)
                somatorioCasosConfirmados = eval(`${dados['totalCasesConfirmed']}+${somatorioCasosConfirmados}`)
            })
            res.json([somatorioMortes, somatorioCasosConfirmados, somatorioRecuperados])
        })
    }

    return {mostraTodos, mediaDeMortes, buscarDadosDasMedias}
}
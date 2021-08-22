const axios = require('axios');
const { connection } = require('../knexfile');
const mysql = require('mysql');
module.exports = app => {
    var connections = mysql.createConnection(connection)
    const mostraTodos = async (req, res, next) => {
        var data = new Date();
        var dataDia = data.getDate();
        var dataMes = data.getMonth();
        var dataParaSubtrair = data.getMonth() - 5;
        var dataAno = data.getFullYear();
        await connections.query('TRUNCATE TABLE covidbrasil', function (error, results) {
            if(error) return res.send(error)
        })
        await axios.get(`https://api.covid19api.com/country/brazil?from=2021-${dataParaSubtrair}-01T00:00:00Z&to=${dataAno}-${dataMes+1}-${dataDia}T00:00:00Z`)
            .then(resposta => {                
                        
                            app.db('covidbrasil')
                            .insert(resposta.data)
                            .then(() => {
                                connections.query('SELECT * FROM covidbrasil ORDER BY Date DESC', function (error, results){
                                    if(error) return res.send(error)

                                    res.json(results)
                                })
                            })
                            .catch(err => res.send(err))
                            
                        
                    
            })
                 
                     
    }  

    const mediaDeMortes = async (req, res) => {
                var valorData = {...req.body}
                var data = `${valorData.dataParaCalculo}T00:00:00Z` //esta é a data principal, a outra é apenas um calculo de 14 dias antes para fazer a media movel
                var data2 = `${valorData.dataHoje}T00:00:00Z`
                connections.query('TRUNCATE TABLE dados_medias_solicitadas', function (error, results) {
                    if(error) return res.send(error)
                })
                connections.query( 'SELECT * FROM covidbrasil WHERE Date >= "'+ data +'" AND Date <= "'+ data2 +'" ORDER BY Date DESC', 
                    function (error, results)  {
                        if (error) return res.send(error)
                        let totalMortes = 0
                        let totalRecuperadas = 0
                        let totalCasosConfirmados = 0
                        let todosOsDados = []
                        results.map((dados, index) => {
                            totalMortes +=  dados['Deaths']
                            totalRecuperadas += dados['Recovered']
                            totalCasosConfirmados += dados['Confirmed']
                            todosOsDados.push(dados)
                             app.db('dados_medias_solicitadas')
                                    .insert(dados)
                                    .then(() => res.json())
                                    .catch(err => res.json('Erro!'))
                                    
                        })
                       
                        let mediaMortes = totalMortes / 14   
                        let mediaRecuperados = totalRecuperadas / 14                  
                        let mediaConfirmados = totalCasosConfirmados / 14                   
                        connections.query(
                            "INSERT INTO media_movel_datas_respectivas (moving_average, Date, totalDeath, totalRecovered, totalCasesConfirmed) VALUES (?, ?, ?, ?, ?)",
                            [mediaMortes, data, totalMortes, mediaRecuperados, mediaConfirmados],
                            function(err, results, fields){
                                if (error) return res.send(error);
                            }
                        ) 
                        res.json([{mediaMortes, mediaConfirmados, mediaRecuperados, todosOsDados}])
                    }
                );

    } 

    const buscarDadosDasMedias = async (req, res) => {
        var valorData = {...req.body}
        var data = `${valorData.data1}T00:00:00Z`
        let somatorioMortes = 0
        let somatorioCasosConfirmados = 0
        let somatorioRecuperados = 0
        var dadosObtidosRequisicao = []
        await connections.query('SELECT * FROM media_movel_datas_respectivas', 
            function (error, results) {
                if(error) return res.send(error)
                results.map((dados, index) => {
                    somatorioMortes = eval(`${dados['totalDeath']}+${somatorioMortes}`)
                    somatorioRecuperados = eval(`${dados['totalRecovered']}+${somatorioRecuperados}`)
                    somatorioCasosConfirmados = eval(`${dados['totalCasesConfirmed']}+${somatorioCasosConfirmados}`)
                })
              
                connections.query(
                    'SELECT * FROM covidbrasil WHERE Date = "'+ data +'"',
                    function(err, results, fields){
                        if (err) return res.send(err);

                        results.map((dados, index) => {
                            dadosObtidosRequisicao.push(dados)
                        })
                        res.json([somatorioMortes, somatorioCasosConfirmados, 
                            somatorioRecuperados, dadosObtidosRequisicao])
                       
                    }
                    
                ) 

        })

    }

    return {mostraTodos, mediaDeMortes, buscarDadosDasMedias}
}
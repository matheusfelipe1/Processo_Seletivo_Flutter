const axios = require('axios');
const { connection } = require('../knexfile');
const mysql = require('mysql');
module.exports = app => {
    var connections = mysql.createConnection(connection)
    const mostraTodos = async (req, res, next) => {
        var dataHoje = new Date().toLocaleDateString().split("/").reverse().join('-');
        var dataParaSubtrair = new Date();
        var todos = [];
        if(dataHoje != null || dataHoje.length != 0) {
            await connections.query('TRUNCATE TABLE covidbrasil', function (error, results) {
                if(error) return res.send(error)
            })
            await axios.get(`https://api.covid19api.com/country/brazil?from=${dataParaSubtrair.getFullYear()}-${dataParaSubtrair.getMonth() - 5}-${dataParaSubtrair.getDate()}T00:00:00Z&to="${dataHoje}T00:00:00Z&to=${dataHoje}T00:00:00Z`)
                .then(resposta => {                
                    app.db('covidbrasil')
                    .insert(resposta.data)
                    .then(() => {
                        connections.query('SELECT * FROM covidbrasil ORDER BY Date DESC', function (error, results){
                            if(error) return res.send(error)
                            var ctt = 0
                            results.forEach(dados => {
                                todos.push(dados)
                                ctt++
                            })
                        res.json([todos])
                        })
                    }).catch(err => res.send(err))
                })
        }else {
            return res.send('Data não pode ser nula!')
        }
    }  
    const mediaDeMortes = async (req, res) => {
                var valorData = {...req.body}
                var data = `${valorData.data}T00:00:00Z` //esta é a data principal, a outra é apenas um calculo de 14 dias antes para fazer a media movel
                var data2 = `${valorData.data2}T00:00:00Z`
                var novosCasos = []
                var novosMortes = []
                var armazenaNovasMortes = []
                var armazenaNovasConfirmados = []
                var todosDados = []
                var totalMortes
                var totalNovosCasos
                var mediaMovelMortes 
                var mediaMovelConfirmados 
                if(valorData.toString() != null || valorData.toString().length != 0) {
                    await connections.query('TRUNCATE TABLE dados_medias_solicitadas', function (error, results) {
                        if (error) return res.send(error)
                    })
                    await connections.query('SELECT * FROM covidbrasil WHERE Date > "'+data2+'" AND Date <="'+data+'" ORDER BY Date DESC', 
                    function (error, results){
                        if(error) return res.send(error)
                        results.map((dados, index) => {
                            novosCasos.push(dados['Confirmed'])
                            novosMortes.push(dados['Deaths'])
                        })
                        todosDados.push(results)
                        for(var i = 0; i < results.length; i++) {
                            armazenaNovasConfirmados.push(novosCasos[i] - novosCasos[i+1])
                            armazenaNovasMortes.push(novosMortes[i] - novosMortes[i+1])
                        }
                        results.pop()
                        /*
                        No algoritmo acima eu tive que gerar os dados das mortes e casos diários,
                        e nessa funcao eu tive que pegar o proximo indice e subtrair pelo atual indice,
                        como esta retornando em ordem decrescente, então tive que usar uma operação inversa
                        para buscar os dados de mortes e novos casos diários
                        */
                        armazenaNovasMortes.pop() 
                        armazenaNovasConfirmados.pop() 
                        totalMortes = armazenaNovasMortes.reduce((value, index) => value + index, 0)
                        totalNovosCasos = armazenaNovasConfirmados.reduce((value, index) => value + index, 0)
                        
                        mediaMovelMortes = totalMortes / 14
                        mediaMovelConfirmados = totalNovosCasos / 14

                        results.forEach((dados, index) => {
                            app.db('dados_medias_solicitadas')
                                .insert({'Country': dados['Country'], 'newCases': armazenaNovasConfirmados[index],
                                'newDeaths': armazenaNovasMortes[index], 'Confirmed': dados['Confirmed'], 'Deaths': dados['Deaths'],
                                'Date': dados['Date']})
                                .then(() => res.send())
                                .catch((err) => res.send(err))
                        })
                        app.db('media_movel_datas_respectivas')
                            .insert({'moving_average': mediaMovelMortes, 'Date': data, 'totalDeath': totalMortes, 'totalCasesConfirmed': totalNovosCasos })
                            .then(() => res.send())
                            .catch((erro) => res.send(erro))
                    
                        res.json({mediaMovelMortes, mediaMovelConfirmados, totalMortes, totalNovosCasos})
                    })

                } else {
                    return res.send('Data não pode ser nula!')
                }
    } 
    const buscarDadosDasMedias = async (req, res) => {
        var valorData = {...req.body}
        var data = `${valorData.data}T00:00:00Z`
        var dadosObjetoSelecionado;
        var mediaMovelMortes = []
        var dadosParaCalcularMedia = []
        var acumuladoMediaMovel;
        if(valorData.toString() != null || valorData.toString().length != 0) {
            connections.query('SELECT moving_average FROM media_movel_datas_respectivas', function (error, results){
                if(error) return res.send(error)
                results.forEach((value, index) => {
                     mediaMovelMortes.push(value["moving_average"])
                }) 
               acumuladoMediaMovel = mediaMovelMortes.reduce((value, index) => value + index, 0)
               Number (acumuladoMediaMovel)
            })
            await app.db('dados_medias_solicitadas')
                .select('Country', 'Date', 'newDeaths', 'Deaths', 'Confirmed', 'newCases')
                .orderBy('Date', 'desc')
                .then((resp) => dadosParaCalcularMedia.push(resp))
                .catch(err => res.send(err))
            await app.db('covidbrasil')
                .select('Country', 'Date', 'Deaths', 'Confirmed', 'Recovered')
                .where({'Date': data})
                .then((resp) => dadosObjetoSelecionado = resp)
                .catch(err => res.send(err))
            res.json({acumuladoMediaMovel, mediaMovelMortes, dadosObjetoSelecionado, dadosParaCalcularMedia})
        }else {
            return res.send('Data não pode ser nula!')
        }   
    }
    const dadosDoMes = async (req, res) => {
        var mes = new Date().getMonth();
        var ano = new Date().getFullYear();
        var dia = Math.abs(new Date().getDay() - new Date().getDay())
        var date = new Date(ano, mes, dia)
        var dataReq = `${date.toLocaleDateString().split("/").reverse().join("-")}T00:00:00Z`;
        var novosCasos = []
        var novosMortes = []
        var armazenaNovasMortes = []
        var armazenaNovasConfirmados = []
        var todosDados = []
        var requisicao = {...req.body}
        var latitude = requisicao.latitude        
        var longitude = requisicao.longitude
        var mortesDaUltimaAtualizacao;        
        var casosDaUltimaAtualizacao;        
            connections.query('SELECT * FROM covidbrasil WHERE Date >= "'+dataReq+'" ORDER BY Date DESC', function (error, results){
                if(error) return res.send(error)
                results.map((dados, index) => {
                    novosCasos.push(dados['Confirmed'])
                    novosMortes.push(dados['Deaths'])
                })
                console.log(results.length);
                console.log(dataReq);
                for(var i = 0; i < results.length; i++) {
                    armazenaNovasConfirmados.push(novosCasos[i] - novosCasos[i+1])
                    armazenaNovasMortes.push(novosMortes[i] - novosMortes[i+1])
                    todosDados.push({confirmed: results[i]["Confirmed"], deaths: results[i]["Deaths"],
                      newDeaths: armazenaNovasMortes[i], newCases: armazenaNovasConfirmados[i] })
                }
                mortesDaUltimaAtualizacao =  armazenaNovasMortes[0]           
                casosDaUltimaAtualizacao =  armazenaNovasConfirmados[0]           
                /*
                No algoritmo acima eu tive que gerar os dados das mortes e casos diários,
                e nessa funcao eu tive que pegar o proximo indice e subtrair pelo atual indice,
                como esta retornando em ordem decrescente, então tive que usar uma operação inversa
                para buscar os dados de mortes e novos casos diários
                */
                todosDados.pop()
                
                var maiorNumeroMortes = todosDados.sort(function(a, b){return b["newDeaths"] - a["newDeaths"]})[0]["newDeaths"];
                var maiorNumeroCasos = todosDados.sort(function(a, b){return b["newCases"] - a["newCases"]})[0]["newCases"];
                var totalMortes = results[0]["Deaths"] 
                var totalCasos = results[0]["Confirmed"]

                app.db('dados_do_mes')
                    .insert({
                    'totalDeaths': totalMortes, 
                    'biggerNewDeaths': maiorNumeroMortes,
                    'Date': new Date(),
                    'totalConfirmed': totalCasos,
                    'biggerNewCases': maiorNumeroCasos,
                    'latitude': latitude, 
                    'longitude': longitude})
                    .then(() => res.send())
                    .catch(err => res.send(err))
                
                    res.json({totalMortes, mortesDaUltimaAtualizacao, casosDaUltimaAtualizacao , maiorNumeroMortes, totalCasos, maiorNumeroCasos, results})

              })
    }
    return {mostraTodos, mediaDeMortes, buscarDadosDasMedias, dadosDoMes}
}
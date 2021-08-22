const axios = require('axios');
const { connection } = require('../knexfile');
const mysql = require('mysql');
module.exports = app => {
    var connections = mysql.createConnection(connection)
    const mostraTodos = async (req, res, next) => {
        var dataHoje = new Date().toLocaleDateString().split("/").reverse().join('-');
        var dataParaSubtrair = new Date();
        var todos = [];
        await connections.query('TRUNCATE TABLE covidbrasil', function (error, results) {
           if(error) return res.send(error)
        })
        await axios.get(`https://api.covid19api.com/country/brazil?from=${dataParaSubtrair.getFullYear()}-${dataParaSubtrair.getMonth() - 5}-${dataParaSubtrair.getDate()}T00:00:00Z&to="${dataHoje}T00:00:00Z`)
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
                connections.query('SELECT * FROM covidbrasil WHERE Date >= "'+data2+'" AND Date <="'+data+'" ORDER BY Date DESC', function (error, results){
                    if(error) return res.send(error)
                    results.map((dados, index) => {
                        novosCasos.push(dados['Confirmed'])
                        novosMortes.push(dados['Deaths'])

                        app.db('dados_medias_solicitadas')
                            .insert(dados)
                            .then(() => res.send())
                            .catch((err) => res.send(err))
                    })

                    todosDados.push(results)
                    for(var i = 0; i < results.length; i++) {
                        armazenaNovasConfirmados.push(novosCasos[i] - novosCasos[i+1])
                        armazenaNovasMortes.push(novosMortes[i] - novosMortes[i+1])
                    }
                    /*
                    No algoritmo acima eu tive que gerar os dados das mortes e casos diários,
                    e nessa funcao eu tive que pegar o proximo indice e subtrair pelo atual indice,
                    como esta retornando em ordem decrescente, então tive que usar uma operação inversa
                    para buscar os dados de mortes e novos casos diários

                    */
                    armazenaNovasMortes.pop() 
                    armazenaNovasConfirmados.pop() 
                    var totalMortes = armazenaNovasMortes.reduce((value, index) => value + index, 0)
                    var totalNovosCasos = armazenaNovasConfirmados.reduce((value, index) => value + index, 0)
                    
                    var mediaMovelMortes = totalMortes / 14
                    var mediaMovelConfirmados = totalNovosCasos / 14
                   
                    connections.query('INSERT INTO media_movel_datas_respectivas (moving_average, Date, totalDeath, totalCasesConfirmed) VALUES (?,?,?,?,?)', 
                    [mediaMovelMortes, data, totalMortes,  totalNovosCasos],
                    function (error, results){

                    })

                    res.json({  mediaMovelMortes, mediaMovelConfirmados, totalMortes, totalNovosCasos})
                    
                })
                

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
                        res.json(dadosObtidosRequisicao)
                        console.log(dadosObtidosRequisicao); 
                       
                    }
                    
                ) 

        })

    }

    const dadosDoMes = async (req, res) => {

        var params = {...req.body}
        var data = `${params.data}T00:00:00Z` //esta é a data principal, a outra é apenas um calculo de 14 dias antes para fazer a media movel
        var data2 = `${params.data2}T00:00:00Z`
        var dataHoje = `${params.dataConsulta}`
        var novosCasos = []
        var novosMortes = []
        var armazenaNovasMortes = []
        var armazenaNovasConfirmados = []
        var todosDados = []
        var dataApi = []
        connections.query('SELECT * FROM covidbrasil WHERE Date >= "'+data2+'" AND Date <="'+data+'" ORDER BY Date DESC', function (error, results){
            if(error) return res.send(error)
            results.map((dados, index) => {
                novosCasos.push(dados['Confirmed'])
                novosMortes.push(dados['Deaths'])
                dataApi.push(dados['Date'])
            })

            todosDados.push(results)
            for(var i = 0; i < results.length; i++) {
                armazenaNovasConfirmados.push(novosCasos[i] - novosCasos[i+1])
                armazenaNovasMortes.push(novosMortes[i] - novosMortes[i+1])
            }
            /*
            No algoritmo acima eu tive que gerar os dados das mortes e casos diários,
            e nessa funcao eu tive que pegar o proximo indice e subtrair pelo atual indice,
            como esta retornando em ordem decrescente, então tive que usar uma operação inversa
            para buscar os dados de mortes e novos casos diários

            */
            armazenaNovasMortes.pop() 
            armazenaNovasConfirmados.pop() 
            

            for (var i in results) {
            connections.query('INSERT INTO dados_do_mes (Deaths, Date, DateApi, Confirmed, latitude, longitude) VALUES (?,?,?,?,?,?)', 
            [armazenaNovasMortes[i], dataApi[i], dataHoje, armazenaNovasConfirmados[i], params.latitude, params.longitude],
            function (error, results){

        })
        }})
    }

    return {mostraTodos, mediaDeMortes, buscarDadosDasMedias, dadosDoMes}
}
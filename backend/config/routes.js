module.exports = app => {
    app.route('/obterlista')
        .get(app.api.data.mostraTodos)

    app.route('/obtermedia')
        .post(app.api.data.mediaDeMortes)
    
    app.route('/obterdadosmedia')
        .post(app.api.data.buscarDadosDasMedias)

    app.route('/dadosmes')
    .post(app.api.data.dadosDoMes)
}
module.exports = app => {
    app.route('/user')
        .get(app.api.data.mostraTodos)

    app.route('/get')
        .post(app.api.data.mediaDeMortes)
}
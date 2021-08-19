module.exports = app => {
    app.route('/user')
    .get(app.api.data.mostra)
}
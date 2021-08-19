const axios = require('axios');

module.exports = app => {
    const mostra = async (req, res, next) => {
        await axios.get('https://api.covid19api.com/country/brazil')
            .then(resp => res.send(resp.data))

    }  

    return {mostra}
}
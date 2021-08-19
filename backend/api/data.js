const axios = require('axios');

module.exports = app => {
    
    const mostra = async (req, res, next) => {
        await axios.get('https://api.covid19api.com/country/brazil')
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

    return {mostra}
}
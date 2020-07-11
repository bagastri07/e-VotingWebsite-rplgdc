const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const request = require('request')

router.get('/pemilih', (req, res) => {
   let whereSql = ''
    if (req.query.id) {
        whereSql = "WHERE id_Mahasiswa = '"+ req.query.id +"' "
    }

    let queryString = `
    SELECT data_pemilih.id_Mahasiswa AS NIM,
    data_token.Token AS Token,
    data_token.Status AS Status
    FROM data_pemilih
    LEFT JOIN data_token ON data_pemilih.id_Token = data_token.id_Token
    `;
    
    db.query(queryString + whereSql, [req.query.id], (err, results) => {
        if (err) {
            res.json({status: err})
        } else {
            res.json(results)
        }
    })
    
})

module.exports = router
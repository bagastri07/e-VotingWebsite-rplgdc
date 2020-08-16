const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const verifyToken = require('../../auth/verify-token')

router.get('/acara', verifyToken.superadmin, (req, res) => {
    let queryString = `
    SELECT *
    FROM data_acara
    `;
    
    db.query(queryString, (err, results) => {
        if (err) {
            res.json({status: err})
        } else {
            res.json(results)
        }
    })
})


module.exports = router
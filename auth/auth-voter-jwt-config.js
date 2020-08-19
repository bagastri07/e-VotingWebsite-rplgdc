const express = require('express')
const router = express.Router()
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt')
const db = require('../database/conn')

const getMahasiswaById = (id) => {
    return new Promise((resolve, reject) => {
        db.query('SELECT * FROM data_pemilih WHERE id_Mahasiswa = ?', [id], (err, results) => {
            if (err) {
                return reject(err)
            } else {
                if (results.lenght < 0) {
                    return resolve(null)
                }
                return resolve(results[0])
            }
        })
    })
}

//just for testing
// async function get(id) {
//     let test = await getMahasiswaById(id)
//     console.log(test)}

// get(1301194051)

router.post('/login', async (req, res) => {
    var nimVoter = req.body.nim
    var tokenVoter = req.body.token
    var voter = await getMahasiswaById(nimVoter)

    if (voter == null) {
        return res.json({auth: false, token: null})
    } else {
        try {
            if (await bcrypt.compare(tokenVoter, voter.Token)) {
                var token = jwt.sign({
                    id: voter.id_Pemilih,
                    role: 'voter',
                    statusToken: voter.status_token,
                    idMahasiswa: voter.id_Mahasiswa,
                    idAcara: voter.id_acara
                }
                , process.env.ACCESS_TOKEN_JWT, {expiresIn: "2h"})
                res.status(200).json({auth: true, token: token})
            } else {
                res.status(403).json({auth: false, token: null})
            }
        } catch (error) {
           return res.json({auth: false, token: null})
        }
    }
})

router.post('/logout', function(req, res) {
    res.status(200).json({ auth: false, token: null });
  })

module.exports = router
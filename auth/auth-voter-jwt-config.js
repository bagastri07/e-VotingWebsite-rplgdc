const express = require('express')
const router = express.Router()
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt')
const db = require('../database/conn')

function getUserByStudentId(NIM) {
    return new Promise((resolve, reject) => {
        db.query('SELECT * FROM data_pemilih WHERE id_mahasiswa = ?', [NIM], (err, result) => {
            if (result.length == 0) {
                resolve(null)
            } else {
                resolve(result)
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
    var voter = await getUserByStudentId(nimVoter)

    if (voter == null) {
        return res.json({auth: false, token: null})
    } else {
        try {
            //console.log(voter)
            for (let i = 0; i < voter.length; i++) {
                if (await bcrypt.compare(tokenVoter, voter[i].Token)) {
                    Data = voter[i]
                    var token = jwt.sign({
                        id: Data.id_Pemilih,
                        role: 'voter',
                        statusToken: Data.status_token,
                        idMahasiswa: Data.id_Mahasiswa,
                        idAcara: Data.id_acara
                    }
                    , process.env.ACCESS_TOKEN_JWT, {expiresIn: "2h"})
                    return res.status(200).json({auth: true, token: token})
                }
            }
           // res.status(403).json({auth: false, token: null})
        } catch (error) {
           return res.json({auth: false, token: 'fuck'})
        }
    }
})

router.post('/logout', function(req, res) {
    res.status(200).json({ auth: false, token: null });
  })

module.exports = router
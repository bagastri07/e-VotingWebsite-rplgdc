const express = require('express')
const router = express.Router()
const db = require('../../conn')
const request = require('request')
const bcrypt = require("bcrypt")
const passport = require('passport')

const initPassport = require('../../controller/auth-admin-passport-config')
const con = require('../../conn')

// function getUserByStudentId(NIM) {
//     db.query('SELECT * FROM data_admin WHERE id_mahasiswa = ?', [NIM], (err, result) => {
        
//         if (!result) {
//             return null
//         } else {
//             let data = JSON.parse(JSON.stringify(result[0]))
//             console.log(data)
//             return data
//         }
//     })
// }
// getUserByStudentId('1301194051')

router.get('/admin', (req, res) => {
    res.send('testing')
})

router.post('/admin', async (req, res) => {
    try {
        const hashedPassword = await bcrypt.hash(req.body.password, 10)
        var adminData = {
            password: hashedPassword,
            email: req.body.email,
            id_Mahasiswa: req.body.nim,
            id_Acara: req.body.id_Acara,
            id_Organisasi: req.body.id_Organisasi
        }
        let quaryString = 'INSERT INTO data_admin SET ?'
        //console.log(adminData)
        db.query(quaryString, [adminData], (err, result) => {
            if (err) {
                res.json({status: err})
            } else {
                res.json({rowAffected: result.rowAffected, msg: 'post success'})
            }
        })
    } catch {
        res.status(500).send()
    }
})

module.exports = router
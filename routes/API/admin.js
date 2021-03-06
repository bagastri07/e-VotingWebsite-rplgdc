const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const verifyToken = require('../../auth/verify-token')

router.get('/admin', verifyToken.role('superadmin'), (req, res) => {
    res.json({
        name : 'Bagas Tri Wibowo (Admin)'
    })
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
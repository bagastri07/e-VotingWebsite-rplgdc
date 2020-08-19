const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const verifyToken = require('../../auth/verify-token')
const multer = require('multer')
const path = require('path')

//set storage engine
const storage = multer.diskStorage({
    destination: path.join(__dirname + '../../../public/images'),
    filename: function(req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname))
    }
})

const upload = multer({
    storage: storage,
    fileFilter: (req, file, cb) => {
        var ext = path.extname(file.originalname)
        if (ext !== '.png' && ext !== '.jpg' && ext !== '.jpeg') {
            return cb(new Error('Please Upload JPG, JPEG, or PNG file!'))
        }
        cb(null, true)
    }
}).single('logo-event')

router.get('/acara', verifyToken.role('superadmin'), (req, res) => {
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

router.get('/acara/:id', verifyToken.role('ALL'), (req, res) => {
    let queryString = `
    SELECT *
    FROM data_acara
    WHERE id_acara = ?
    `;
    
    db.query(queryString, [req.params.id], (err, results) => {
        if (err) {
            res.json({status: err})
        } else {
            res.json(results[0])
        }
    })
})

router.post('/acara', verifyToken.role('superadmin'), (req, res) => {
    upload(req, res, (err) => {
        if (err) throw err

        var data = {
            Nama_Acara      : req.body.name,
            image           : req.file.filename,
            Tanggal_Mulai   : req.body.tanggal_mulai,
            Waktu_Mulai     : req.body.waktu_mulai,
            Tanggal_Berakhir: req.body.tanggal_berakhir,
            Waktu_Berakhir  : req.body.waktu_berakhir
        }
        let sql = `INSERT INTO data_acara SET ?`
        db.query(sql, data, (err, results) => {
            if (err) {
                res.json({status: err})
            } else {
                res.json({
                    Msg: `${data.Nama_Acara} was added to database`,
                    'row affected': results.affectedRows
                })
            }
        })
    })
})


module.exports = router
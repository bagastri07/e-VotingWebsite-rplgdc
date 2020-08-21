const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const verifyToken = require('../../auth/verify-token')
const multer = require('multer')
const path = require('path')
const fs = require('fs')
const con = require('../../database/conn')
const { toASCII } = require('punycode')
const { count } = require('console')

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
        if (err) {
            res.json({msg: err})
        } else {
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
        }
    })
})

router.delete('/acara/:id', verifyToken.role('superadmin'), (req, res) => {
    
    let SQL = `DELETE FROM data_acara WHERE id_acara = ?`
    db.query(SQL, [req.params.id], (err, results) => {
        if (err) {
            res. json({status: err})
        } else {
            if (results.affectedRows < 0) {
                res.json({
                    msg: 'No Event Found',
                    'row Affected': results.affectedRows
                })
            } else {
                res.json({
                    Msg: 'delete Success',
                    'row affected': results.affectedRows
                })
            }
        }
    })
})

router.put('/edit-acara/:id', verifyToken.role('superadmin'), (req, res) => {
    upload(req, res, (err) => {
        if (err) {
            res.json({msg: err})
        } else {
            let SQL
            if (!req.file) {
                SQL = ` 
                UPDATE data_acara
                SET Nama_Acara = '${req.body.nama_acara}'
                , Tanggal_Mulai = '${req.body.tanggal_mulai}'
                , Waktu_Mulai = '${req.body.waktu_mulai}'
                , Tanggal_Berakhir = '${req.body.tanggal_berakhir}'
                , Waktu_Berakhir = '${req.body.waktu_berakhir}'
                WHERE id_acara = ?
                `
            } else {
                SQL = ` 
                UPDATE data_acara
                SET Nama_Acara = '${req.body.nama_acara}'
                , Tanggal_Mulai = '${req.body.tanggal_mulai}'
                , Waktu_Mulai = '${req.body.waktu_mulai}'
                , Tanggal_Berakhir = '${req.body.tanggal_berakhir}'
                , Waktu_Berakhir = '${req.body.waktu_berakhir}'
                , image = '${req.file.filename}'
                WHERE id_acara = ?
                `
            }
            db.query(SQL, [req.params.id], (err, results) => {
                if (err) {
                    res.json({msg: err})
                } else {
                    res.json({
                        msg: 'update succes',
                        'affectedRow': results.affectedRows
                    })
                }
            })
        }
    })
})

router.get('/hitung-suara/:id', verifyToken.role('superadmin'), (req, res) => {
    let SQL = `
    SELECT id_Paslon, No_Urut FROM data_paslon WHERE id_acara = ?
    `
    db.query(SQL, [req.params.id], (err,results_paslon) => {
        if(err){
            res.json({msg: err})
        } else {

            let queryString = `
            SELECT id_pemilih,
            status_token,
            Id_Paslon_Pilihan AS id_Paslon
            FROM data_pemilih
            WHERE id_acara = ?`
            db.query(queryString, [req.params.id], async (err, results_vote) => {
                if (err) {
                    res.json({msg: err})
                } else {

                    const data = await hitungSuara(results_paslon, results_vote)
            
                    res.json({data: data})
                }
            })
        }
    })
    
})

router.get('/suara-masuk/:id', verifyToken.role('superadmin'), (req, res) => {
    let queryString = `SELECT status_token FROM data_pemilih WHERE id_acara = ?`
    db.query(queryString, [req.params.id], (err, results) => {
        if (err) {
            res.json({msg:err})
        } else {
            let jumlahPemilih = results.length
            let jumlahSuara = 0
            for (let i = 0; i < results.length; i++) {
                if (results[i].status_token === 'used') {
                    jumlahSuara++
                }
            }
            res.json({
                jumlahPemilih: jumlahPemilih,
                jumlahSuaraMasuk: jumlahSuara,
                jumlahSuaraBelumTerpakai: jumlahSuara - jumlahSuara,
                persentaseSuaraMasuk: (jumlahSuara/jumlahPemilih) * 100
            })
        }
    })
})

function hitungSuara(dataPaslon, dataAcara) {
    return new Promise((resolve, reject) => {
         //Menghitung suara
         const data = []
         let suara
         let totalSuara = 0
         for (let i = 0; i < dataPaslon.length; i++) {
             suara = 0
             for (let j = 0; j < dataAcara.length; j++) {
                 if (dataPaslon[i].id_Paslon === dataAcara[j].id_Paslon) {
                     suara++
                 }
             }
             totalSuara = totalSuara + suara
             data.push({
                id_Paslon: dataPaslon[i].id_Paslon,
                No_Urut: dataPaslon[i].No_Urut,
                jumlah_suara: suara,
                persentase: null
             })
         }

         //Menghitung persentase suara
         for (let i = 0; i < data.length; i++) {
            let persentase = (data[i].jumlah_suara / totalSuara) * 100
            data[i].persentase = persentase
        }
         resolve(data)
    })
}



module.exports = router
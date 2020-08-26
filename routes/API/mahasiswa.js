const express = require('express')
const router = express.Router()
const db = require('../../database/conn')

router.get('/mahasiswa', (req, res) => {
    let whereQuery = ''
    if(req.query.id) {
        whereQuery = "WHERE id_Mahasiswa = '"+req.query.id+"'"
    } 
    if(req.query.nama) {
        whereQuery = "WHERE nama_Mahasiswa = '"+req.query.nama+"'"
    }
    let queryString = `
    SELECT data_mahasiswa.nama_mahasiswa AS nama,
    data_mahasiswa.jenis_Kelamin,
    data_mahasiswa.angkatan,
    data_jurusan.nama_Jurusan AS Jurusan
    FROM data_mahasiswa
    LEFT JOIN data_jurusan ON data_mahasiswa.id_Jurusan = data_jurusan.id_Jurusan
    `;
    
    
    db.query(queryString + whereQuery, (err, results) => {
        if(err) {
            res.json({status: err})
        } else {
            res.json(results)
        }
    })
})


// Menambah data_Mahasiswa
router.post('/mahasiswa', (req, res) => {
    var data = {
        id_Mahasiswa: req.query.id,
        nama_Mahasiswa: req.query.nama,
        jenis_Kelamin: req.query.jk,
        angkatan: req.query.angkatan,
        id_Jurusan: req.query.id_jur
    }
    let queryString = 'INSERT INTO data_mahasiswa SET ?'
    db.query(queryString, data, (err, results) => {
        if (err) {
            res.json({status : err})
        } else {
            res.json({
                'row affected': results.affectedRows,
                msg : "POST Success"
            })
        }
    })
})


router.delete('/mahasiswa', (req, res) => {
    let data = req.query.id
    let queryString = 'DELETE From data_mahasiswa WHERE id_Mahasiswa  = ?'
    db.query(queryString, [data], (err, results) => {
        if (err) {
            res.json({status : err})
        } else {
            res.json({
                'Row Affected': results.affectedRows,
                msg : "DELETE Success"
            })
        }

    })
})




module.exports = router
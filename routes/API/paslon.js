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
}).single('img-paslon')

const getMahasiswaById = (id, res) => {
    return new Promise((resolve, reject) => {
        db.query('SELECT id_Mahasiswa, nama_Mahasiswa, jenis_Kelamin, angkatan FROM data_mahasiswa WHERE id_Mahasiswa = ?', [id], (err, results) => {
            if (err) {
                return reject(err)
            } else {
                return resolve(results[0])
            }
        })
    })
}

const getAcaraById = (id, res) => {
    return new Promise((resolve, reject) => {
        db.query('SELECT * FROM data_acara WHERE id_acara = ?', [id], (err, results) => {
            if (err) {
                return reject(err)
            } else {
                return resolve(results[0])
            }
        })
    })
}

async function asyncForEach(array, callback) {
    for (let index = 0; index < array.length; index++) {
      await callback(array[index], index, array);
    }
}

router.get('/paslon/:idacara', verifyToken.superadmin, (req, res) => {
    let queryString = `
    SELECT
    *
    FROM
    data_paslon
    WHERE id_Acara = ?
    `;

    let id = req.params.idacara
    
    db.query(queryString, id, async (err, acara_results) => {
        if (err) {
            res.json({status: err})
        } else {
            let data_acara = []
            
            await asyncForEach(acara_results, async (element) => {
                const ketua = await getMahasiswaById(element.id_ketua, res).catch(results => {
                    res.json(results)
                })
                const wakil = await getMahasiswaById(element.id_wakil, res).catch(results => {
                    res.json(results)
                })
                const acara = await getAcaraById(element.id_acara, res).catch(results => {
                    res.json(results)
                })
                data_acara.push({
                    id_paslon: element.id_Paslon,
                    ketua: ketua,
                    wakil: wakil,
                    acara: acara
                })
                
            })
            
            res.json(data_acara)
        }
    })
})

router.post('/paslon', verifyToken.superadmin, (req, res) => {
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
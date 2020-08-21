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

router.get('/paslon', verifyToken.role('ALL'), (req, res) =>{
    let queryString =`
    SELECT * FROM data_paslon WHERE id_
    `
})

router.get('/paslon-acara/:idacara', verifyToken.role('ALL'), (req, res) => {
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
                    acara: acara,
                    Visi: element.Visi,
                    Misi: element.Misi,
                    image: element.image
                })
                
            })
            
            res.json(data_acara)
        }
    })
})

router.post('/paslon', verifyToken.role('superadmin'), (req, res) => {
    upload(req, res, (err) => {
        if (err) throw err

        var data = {
            id_ketua        : req.body.nim_ketua,
            id_wakil        : req.body.nim_wakil,
            image           : req.file.filename,
            No_Urut         : req.body.No_Urut,
            Visi            : req.body.Visi,
            Misi            : req.body.Misi,
            id_acara        : req.body.id_acara
        }
        let sql = `INSERT INTO data_paslon SET ?`
        db.query(sql, data, (err, results) => {
            if (err) {
                res.json({status: err})
            } else {
                res.json({
                    Msg: `Paslon ${data.id_ketua} & ${data.id_wakil} was added to database`,
                    'row affected': results.affectedRows
                })
            }
        })
    })
})

router.delete('/paslon/:id', verifyToken.role('superadmin'), (req, res) => {
    let queryString = `DELETE FROM data_paslon WHERE id_Paslon = ?`
    db.query(queryString, [req.params.id], (err, results) => {
        if (err) {
            res.json({
                msg: err
            })
        } else {
            res.json({
                msg:'succes',
                'affectedRow': results.affectedRows
            })
        }
    })
})

//belum selesai
router.put('/edit-paslon/:id', verifyToken.role('superadmin'), (req, res) => {
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

module.exports = router
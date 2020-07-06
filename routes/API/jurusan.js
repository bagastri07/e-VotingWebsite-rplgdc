const express = require('express')
const router = express.Router()
const db = require('../../conn')
const request = require('request')

async function asyncForEach(array, callback) {
    for (let index = 0; index < array.length; index++) {
      await callback(array[index], index, array);
    }
}

const getMahasiswaById = (id, res) => {
    return new Promise((resolve, reject) => {
        db.query('SELECT id_Mahasiswa, nama_Mahasiswa, jenis_Kelamin, angkatan FROM data_mahasiswa WHERE id_Jurusan = ?', [id], (err, results) => {
            if (err) {
                return reject(err)
            } else {
                return resolve(results)
            }
        })
    })
}

router.get('/detail_jurusan', (req, res) => {
    db.query('SELECT * FROM data_jurusan', async (err, jurusan_result) => {
        if (err) {
            res.json({msg: err})
        } else {
            let data_jurusan = {jurusan: []}

            await asyncForEach(jurusan_result, async(element) => {
                const mahasiswa = await getMahasiswaById(element.id_Jurusan, res).catch(results => {
                    res.json(results)
                })

                data_jurusan.jurusan.push({
                    id_Jurusan: element.id_Jurusan,
                    nama_Jurusan: element.nama_Jurusan,
                    mahasiswa: mahasiswa
                })
            })
            res.json(data_jurusan)
        }
    })
})



router.get('/jurusan', (req, res) => {
    db.query('SELECT * FROM data_jurusan ', (err, results) => {
        if(err) {
            res.json({status: err})
        } else {
            res.json(results)
        }
    })
})

module.exports = router
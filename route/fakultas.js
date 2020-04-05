const express = require('express')
const router = express.Router()
const db = require('../conn')
const request = require('request')

router.get('/fakultas', (req, res) => {
    db.query('SELECT * FROM data_fakultas ', (err, results) => {
        if(err) {
            res.json({status: err})
        } else {
            res.json(results)
        }
    })
})

async function asyncForEach(array, callback) {
    for (let index = 0; index < array.length; index++) {
      await callback(array[index], index, array);
    }
}

const getJurusanById = (id, res) => {
    return new Promise((resolve, reject) => {
        db.query('SELECT nama_jurusan FROM data_jurusan WHERE id_Fakultas = ?', [id], (err, results) => {
            if (err) {
                return reject(err)
            } else {
                return resolve(results)
            }
        })
    })
}

router.get('/detail_fakultas', (req, res) => {
    db.query('SELECT * FROM data_fakultas', async (error, fakultas_results) => {
        if (error) {
            res.json({status : error})
        } else {
            let data_fakultas = {fakultas : []}

            await asyncForEach(fakultas_results, async (element) => {
                const jurusan = await getJurusanById(element.id_Fakultas, res).catch(result => {
                    res.json(result)
                })

                data_fakultas.fakultas.push({
                    id_Fakultas : element.id_Fakultas,
                    nama_Fakultas : element.nama_Fakultas,
                    jurusan : jurusan
                })

                
            })
            res.json(data_fakultas)
        }
    })
})

module.exports = router
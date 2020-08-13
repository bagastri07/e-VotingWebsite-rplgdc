const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const bcrypt = require('bcrypt')

const verifyToken = require('../../auth/verify-token')

router.get('/pemilih', verifyToken.superadmin, (req, res) => {
   let whereSql = ''
    if (req.query.id) {
        whereSql = "WHERE id_Mahasiswa = '"+ req.query.id +"' "
    }

    let queryString = `
    SELECT data_mahasiswa.nama_mahasiswa AS nama,
    data_pemilih.Id_Mahasiswa AS nim,
    data_pemilih.Token AS Token,
    data_pemilih.email AS email
    FROM data_mahasiswa
    RIGHT JOIN data_pemilih ON data_mahasiswa.id_Mahasiswa = data_pemilih.id_Mahasiswa
    `;
    
    db.query(queryString + whereSql, [req.query.id], (err, results) => {
        if (err) {
            res.json({status: err})
        } else {
            res.json(results)
        }
    })
    
})

router.post('/pemilih', async (req, res) => {
    try {
        var token = makeToken(5)
        console.log(token)
        const hashedPassword = await bcrypt.hash(token, 10)
        var Data = {
            Token: hashedPassword,
            email: req.body.email,
            id_Mahasiswa: req.body.nim,
            id_nama_Acara_Pemilu: req.body.acara
        }
        let quaryString = 'INSERT INTO data_pemilih SET ?'
        //console.log(Data)
        db.query(quaryString, [Data], (err, result) => {
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

router.delete('/pemilih/:nim', (req, res) => {
    let nim = req.params.nim
    let queryString = 'DELETE From data_pemilih WHERE id_Mahasiswa  = ?'
    db.query(queryString, [nim], (err, results) => {
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

function makeToken(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
 }

module.exports = router
const express = require('express')
const router = express.Router()

//for the all APIs route
const fakultas = require('./fakultas')
const jurusan = require('./jurusan')
const mahasiswa = require('./mahasiswa')
const pemilih = require('./pemilih')
const admin = require('./admin')
const authAPI = require('./authAPI')

//the use of the APIs
router.use(fakultas)
router.use(jurusan)
router.use(mahasiswa)
router.use(pemilih)
router.use(admin)
router.use(authAPI)

module.exports = router
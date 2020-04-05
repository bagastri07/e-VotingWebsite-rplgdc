const express = require('express')
const app = express()
const bodyParser = require('body-parser')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))

const fakultas = require('./route/fakultas')
const jurusan = require('./route/jurusan')
const mahasiswa = require('./route/mahasiswa')
const pemilih = require('./route/pemilih')

app.use(fakultas)
app.use(jurusan)
app.use(mahasiswa)
app.use(pemilih)

app.get('/', (req, res) => {
    res.send('Server Running')
}) 

app.listen(8888, () => {
    console.log('Server is running on port 8888')
})
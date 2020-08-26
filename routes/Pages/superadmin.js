const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const passport = require('passport')
const axios = require('axios')
const authMiddleware = require('../../middleware/Auth')
const multer = require('multer')
const path = require('path')

const initializePassport = require('../../controller/auth-passport-config')
initializePassport(passport)

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

router.get('/', authMiddleware.isLogin('/super/dashboard'), (req, res) => {
    res.render('loginsuperadmin')
})

router.post('/login', passport.authenticate('superadmin', { failureRedirect: '/super', failureFlash: true}), (req, res) => {
    axios.post('http://localhost:8888/auth/sa/login', {
        username: req.body.username,
        password: req.body.password
      })
      .then(function (response) {
        //console.log(response.data);
        let token = response.data.token
        // console.log(req.user)
        res.cookie('token', token, {httpOnly: false, maxAge: 2 * 60 * 60 * 1000}) 
        res.redirect('/super/dashboard')
      })
      .catch(function (error) {
        console.log(error);
      });
})

router.get('/logout', (req, res) => {
    req.logOut()
    res.cookie('token', null, {maxAge: 1})
    res.redirect('/super')
})

router.get('/dashboard', authMiddleware.role('superadmin', '/super') ,(req, res) => {
    // console.log(req.user)
    res.render('Home-SA', {name: req.user.username})
})

router.get('/events', authMiddleware.role('superadmin', '/super'), (req, res) => {
    res.render('DaftarEvent-SA')
})

router.get('/organizations', authMiddleware.role('superadmin', '/super'), (req, res) => {
    res.render('DaftarOrganisasi-SA')
})

router.get('/admins', authMiddleware.role('superadmin', '/super'), (req, res) => {
    res.render('DaftarAdmin-SA')
})

router.get('/realtimecount', authMiddleware.role('superadmin', '/super'), (req, res) => {
    res.render('realtimecount-superadmin')
})

router.get('/candidates', authMiddleware.role('superadmin', '/super'), (req, res) => {
    res.render('candidates-superadmin')
})

router.get('/voters/:id', authMiddleware.role('superadmin', '/super'), (req, res) => {
    axios.get(`http://localhost:8888/api/pemilih/${req.params.id}`, {
        headers: {
            'Authorization': `Bearer ${req.cookies.token}`
        }
    })
    .then((results) => {
        var voters = []
        //console.log(results.data)
        res.render('DaftarPemilih-SA', {voters: voters})
    })
    .catch((err) => {
        console.log(err)
    })
})

router.get('/addevent', authMiddleware.role('superadmin', '/super'), (req, res) => {
    res.render('FormDaftarEvent-SA')
})

router.get('/Up', (req, res) => {
    res.render('uploadImg')
})

router.post('/up', (req, res) => {
    upload(req, res, function(err) {
        if (err) return res.send(err.message)

        var sql = `UPDATE data_acara SET image = '${req.file.filename}' WHERE data_acara.id_acara = 2 `
        db.query(sql, (err, ressults) => {
            if (err) throw err
            console.log(ressults)
            res.send('Uploaded')
        })
    })
})

module.exports = router
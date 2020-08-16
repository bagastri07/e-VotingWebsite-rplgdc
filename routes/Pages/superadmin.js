const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const passport = require('passport')
const axios = require('axios')
const authMiddleware = require('../../middleware/Auth')

const initializePassport = require('../../controller/auth-superadmin-passport-config')
const con = require('../../database/conn')
const { compareSync } = require('bcrypt')
initializePassport(passport)

router.get('/', (req, res) => {
    res.render('loginsuperadmin')
})

router.post('/login', passport.authenticate('super', { failureRedirect: '/super', failureFlash: true}), (req, res) => {
    axios.post('http://localhost:8888/auth/sa/login', {
        username: req.user.username,
        password: req.user.password
      })
      .then(function (response) {
        //console.log(response.data);
        let token = response.data.token
        req.user.password = null
        res.cookie('token', token, {httpOnly: true, maxAge: 2 * 60 * 60 * 1000}) 
        res.redirect('/super/dashboard')
      })
      .catch(function (error) {
        console.log(error);
      });
})

router.get('/logout', (req, res) => {
    req.logOut()
    res.redirect('/super')
})

router.get('/dashboard', authMiddleware.role('superadmin', '/super') ,(req, res) => {
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

router.get('/voters', authMiddleware.role('superadmin', '/super'), (req, res) => {
    axios.get('http://localhost:8888/api/pemilih', {
        headers: {
            'Authorization': `Bearer ${req.cookies.token}`
        }
    })
    .then((results) => {
        var voters = []
        for (i = 0; i < results.data.length; i++) {
            var data = {
                name: results.data[i].nama,
                email: results.data[i].email,
                nim: results.data[i].nim
            }
            voters.push(data)
          } 
        console.log(voters)
        res.render('DaftarPemilih-SA', {voters: voters})
    })
    .catch((err) => {
        console.log(err)
    })
})

router.get('/addevent', authMiddleware.role('superadmin', '/super'), (req, res) => {
    res.render('FormDaftarEvent-SA')
})

module.exports = router
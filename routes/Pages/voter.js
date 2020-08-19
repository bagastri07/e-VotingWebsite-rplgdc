const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const passport = require('passport')
const axios = require('axios')
const authMiddleware = require('../../middleware/Auth')

const initializePassport = require('../../controller/auth-passport-config')
const con = require('../../database/conn')
const { compareSync } = require('bcrypt')
initializePassport(passport)

router.get('/', authMiddleware.isLogin('/dashboard'), (req, res) => {
    res.render('loginpemilih')
})

router.post('/login', passport.authenticate('voter', { failureRedirect: '/', failureFlash: true}), (req, res) => {
    console.log(req.body)
    axios.post('http://localhost:8888/auth/voter/login', {
        nim: req.body.NIM,
        token: req.body.token
      })
      .then(function (response) {
        req.user.Token = null
        // console.log(req.user)
        // console.log(response.data);
        let token = response.data.token
       
        if (req.user.status_token === 'used') {
            return res.send('You are not allowed to vote')
        }
        res.cookie('token', token, {httpOnly: true, maxAge: 2 * 60 * 60 * 1000}) 
        res.redirect('/dashboard')
      })
      .catch(function (error) {
        console.log(error);
      });
})

router.get('/logout', (req, res) => {
    req.logOut()
    res.cookie('token', null, {maxAge: 1})
    res.redirect('/')
})

router.get('/dashboard', authMiddleware.role('voter', '/'), (req, res) => {

    // console.log(req.user)
    res.render('home-Voter', {nama: req.user.nama})
})

router.get('/vote/:idacara', authMiddleware.role('voter', '/'), (req, res) => {
    // 
    axios.get(`http://localhost:8888/api/acara/${req.params.idacara}`, {
        headers: {
            'Authorization': `Bearer ${req.cookies.token}`
        }
    })
    .then((results) => {
        console.log(results.data)
        res.render('VotePaslon-Voter', {nama: req.user.nama, nama_acara: results.data.Nama_Acara})
    })
    .catch((err) => {
        console.log(err)
    })
})

module.exports = router
const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const passport = require('passport')
const axios = require('axios')
const authMiddleware = require('../../middleware/Auth')

const initializePassport = require('../../controller/auth-passport-config')
initializePassport(passport)

router.get('/', (req, res) => {
    res.render('loginpemilih')
})

router.post('/login', passport.authenticate('voter', { failureRedirect: '/', failureFlash: true}), (req, res) => {
    axios.post('http://localhost:8888/auth/voter/login', {
        nim: req.user.username,
        token: req.user.password
      })
      .then(function (response) {
        //console.log(response.data);
        let token = response.data.token
        req.user.Token = null
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
    console.log(req.user)
    res.render('home-Voter', {nama: req.user.nama})
})

module.exports = router
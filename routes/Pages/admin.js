const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const passport = require('passport')
const getToken = require('../../controller/jwt-controller')
const axios = require('axios')

const initializePassport = require('../../controller/auth-admin-passport-config')
const { get } = require('../API/admin')
initializePassport(passport)

router.get('/', (req, res) => {
    res.render('login-admin')
})

router.post('/auth/login', passport.authenticate('local', {
    failureRedirect: '/adm',
    failureFlash: true
}), (req, res) => {
    
    axios.post('http://localhost:8888/api/login', {
        email: req.user.email,
        role: req.user.role
      })
      .then((response) => {
        var data = {
            accessToken: response.data.accessToken,
            refreshToken: response.data.refreshToken
        }
        res.cookie('auth', data.accessToken, {httpOnly: true})
        res.cookie('refresh', data.refreshToken, {httpOnly: true})
        res.redirect('/adm/dashboard')
      }, (error) => {
        console.log(error);
      });
})

router.get('/auth/logout', (req, res) => {
    req.logOut()
    //req.flash('error', "te")
    res.redirect('/adm')
})

router.get('/dashboard', checkIsAdmin, (req, res) => {
    const name = req.user.id_mahasiswa + ' (' + req.user.role + ')'
    res.render('dashboard-admin', {name: name})
    //console.log(req.user.email)
})

function checkIsAdmin (req, res, next) {
    if(req.user) {
        return next()
    } else {
        res.redirect('/adm')
    }
}


module.exports = router
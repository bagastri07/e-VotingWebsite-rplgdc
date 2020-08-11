const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const passport = require('passport')
const axios = require('axios')
const jwtController = require('../../controller/jwt-controller')

const initializePassport = require('../../controller/auth-admin-passport-config')
const { get } = require('../API/admin')
const con = require('../../database/conn')
initializePassport(passport)

router.get('/', (req, res) => {
    res.render('login-admin')
})

router.post('/auth/login', passport.authenticate('admin', {
    failureRedirect: '/adm',
    failureFlash: true
}), (req, res) => {
    //Get Access and RefreshToken
    jwtController.getToken(req.user).then((result) => {
        res.cookie('auth', result.accessToken, {httpOnly: true, overwrite: true, maxAge: 900000})
        res.cookie('ref', result.refreshToken, {httpOnly: true, overwrite: true})
        res.redirect('/adm/dashboard')
    })

})

router.get('/auth/logout', (req, res) => {
    req.logOut()
    res.redirect('/adm')
})

router.get('/dashboard', checkIsAdmin, (req, res) => {
    console.log(req.cookies.auth)
    axios.get('http://localhost:8888/api/admin', {
        headers: {
            'authorization': 'Bearer ' + req.cookies.auth
        }})
        .then((res) => {
            console.log(res.data)
        })
        .catch((err) => {
            console.log(err)
        })

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
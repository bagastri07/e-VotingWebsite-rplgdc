const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const passport = require('passport')

const initializePassport = require('../../controller/auth-superadmin-passport-config')
initializePassport(passport)

router.get('/', (req, res) => {
    res.render('login-super-admin')
})

router.post('/auth/login', passport.authenticate('super', {
    successRedirect: '/super/dashboard',
    failureRedirect: '/super',
    failureFlash: true
}))

router.get('/dashboard', (req, res) => {
    res.send('ok')
})


module.exports = router
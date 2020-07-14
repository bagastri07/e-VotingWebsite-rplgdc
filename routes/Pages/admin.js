const express = require('express')
const router = express.Router()
const db = require('../../database/conn')
const passport = require('passport')

const initializePassport = require('../../controller/auth-admin-passport-config')
initializePassport(passport)

router.get('/', (req, res) => {
    res.render('login-admin')
})

router.post('/auth/login', passport.authenticate('local', {
    successRedirect: '/adm/dashboard',
    failureRedirect: '/adm',
    failureFlash: true
}))


router.get('/dashboard', checkIsAdmin, (req, res) => {
    res.render('dashboard-admin')
    console.log(req.user)
})

function checkIsAdmin (req, res, next) {
    if(req.user) {
        return next()
    } else {
        res.redirect('/')
    }
}


module.exports = router
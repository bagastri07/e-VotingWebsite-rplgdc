const express = require('express')
const router = express.Router()
const jwt = require('jsonwebtoken')

const admin = require('../database/superadmin')

function getSuperAdmin(username, password) {
    if (username == admin.username && password == admin.password) {
        return admin
    } else {
        return null
    }
}

router.post('/login', (req, res) => {
    var username = req.body.username
    var password = req.body.password
    var admin = getSuperAdmin(username, password)

    if (admin == null) {
        return res.json({auth: false, token: null})
    }

    var token = jwt.sign({id: admin.id, role: 'superadmin'}, process.env.ACCESS_TOKEN_JWT, {expiresIn: "2h"})

    res.status(200).json({auth: true, token: token})
})

router.post('/logout', function(req, res) {
    res.status(200).json({ auth: false, token: null });
  })

module.exports = router
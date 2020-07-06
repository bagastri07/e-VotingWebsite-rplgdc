const express = require('express')
const adminAuthController = require('../controller/auth-admin')

const router = express.Router()

router.post('/loginadmin', adminAuthController.login )

module.exports = router

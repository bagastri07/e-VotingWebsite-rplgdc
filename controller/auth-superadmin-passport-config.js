const LocalStrategy = require('passport-local').Strategy
const bcrypt = require('bcrypt')
const db = require('../conn')

const admin = {
    username: process.env.SUPERADMIN_USERNAME,
    password: process.env.SUPERADMIN_PASSWORD
}
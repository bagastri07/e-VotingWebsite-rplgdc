const LocalStrategy = require('passport-local').Strategy
const passport = require('passport');

const admin = require('../database/superadmin');

function getSuperAdminById(id) {
    if (id == admin.id) {
        let data = {
            id: admin.id,
            username: admin.username,
            password: admin.password,
            role: 'superadmin'
        }
        return data
    }
}

function getSuperAdminByUsername(username) {
  if (username == admin.username) {
    let data = {
      id: admin.id,
      username: admin.username,
      password: admin.password,
      role: 'superadmin'
    }
    return data
  }
  return null
}

function initialize(passport) {
    const authenticateUser = (username, password, done) => {
        const user = getSuperAdminByUsername(username)
        // console.log(user)
        if (user == null) {
            return done(null, false, { message: 'username incorrect' })
        } else {
            if (password == user.password) {
              return done(null, user)
            } else {
              return done(null, false, {message: 'password incorrect'})
            }
      }

      
    }
    passport.use('super', new LocalStrategy({ usernameField: 'username' }, authenticateUser))
    passport.serializeUser((user, done) => done(null, user.id))
    passport.deserializeUser((id, done) => {
      done(null, getSuperAdminById(id))
    })
  }

  module.exports = initialize
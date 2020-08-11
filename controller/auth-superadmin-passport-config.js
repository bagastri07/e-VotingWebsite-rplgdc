const LocalStrategy = require('passport-local').Strategy
const bcrypt = require('bcrypt')

const admin = {
    id: Date.now().toString() ,
    username: process.env.SUPERADMIN_USERNAME,
    password: process.env.SUPERADMIN_PASSWORD
    }

function getSuperAdminById(id) {
    if (admin.id === id) {
        return admin.id
    }
}

function getSuperAdminByUsername(username) {
    if (admin.username === username) {
        return admin
    } else {
        return null
    }
}

function initialize(passport) {
    const authenticateUser = (username, password, done) => {
      const user = getSuperAdminByUsername(username)
      if (user == null) {
          return done(null, false, { message: 'username Inccoret' })
      } else {         
          try {
              if (user.password === admin.password) {
                return done(null, user)
              } else {
                return done(null, false, { message: 'password Inccoret' })
              }
          } catch (e) {
              return done(e)
          }
      }
    }
  
    passport.use('super', new LocalStrategy({ usernameField: 'username' }, authenticateUser))
    passport.serializeUser((user, done) => done(null, user.id))
    passport.deserializeUser((id, done) => {
      done(null,getSuperAdminById(id))
    })
  }

  module.exports = initialize
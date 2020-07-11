const LocalStrategy = require('passport-local').Strategy
const bcrypt = require('bcrypt')

const hashedPassword = bcrypt.hash(process.env.SUPERADMIN_PASSWORD, 10)
const admin = {
    id: Date.now().toString() ,
    username: process.env.SUPERADMIN_USERNAME,
    password: 's'
    }
hashedPassword.then((result) => {
    admin.password = result
})

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
    const authenticateUser = async (username, password, done) => {
      const user = getSuperAdminByUsername(username)
      console.log(user)
      if (user == null) {
          return done(null, false, { message: 'username Inccoret' })
      } else {         
          try {
              if (await bcrypt.compare(password, user.password)) {
                return done(null, user)
              } else {
                return done(null, false, { message: 'password Inccoret' })
              }
          } catch (e) {
              return done(e)
          }
      }
    }
  
    passport.use(new LocalStrategy({ usernameField: 'username' }, authenticateUser))
    passport.serializeUser((user, done) => done(null, user.id))
    passport.deserializeUser((id, done) => {
      done(null,getSuperAdminById(id))
    })
  }

  module.exports = initialize
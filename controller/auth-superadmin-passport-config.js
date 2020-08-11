const LocalStrategy = require('passport-local').Strategy
const axios = require('axios');
const passport = require('passport');

const admin = require('../database/superadmin')

function getSuperAdminById(id) {
    if (id == admin.id) {
        let data = {
            id: admin.id,
            username: admin.username,
            role: 'superadmin'
        }
        return data
    }
}

function getSuperAdmin(username, password) {
    return new Promise((resolve, reject) => {
        axios.post('http://localhost:8888/api/auth/sa/login', {
        username: username,
        password: password
      })
      .then(function (response) {
        //console.log(response.data);
        resolve(response.data)
      })
      .catch(function (error) {
        console.log(error);
      });
    })
}


function initialize(passport) {
    const authenticateUser = async (username, password, done) => {
        const user = await getSuperAdmin(username, password)
        console.log(user)
        if (user.auth == false) {
            return done(null, false, { message: 'username/password Inccoret' })
        } else {
            return done(null, user.admin)         
      }

      
    }
    passport.use('super', new LocalStrategy({ usernameField: 'username' }, authenticateUser))
    passport.serializeUser((user, done) => done(null, user.id))
    passport.deserializeUser((id, done) => {
      done(null, getSuperAdminById(id))
    })
  }

  module.exports = initialize
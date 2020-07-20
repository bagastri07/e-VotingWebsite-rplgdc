const LocalStrategy = require('passport-local').Strategy
const bcrypt = require('bcrypt')
const db = require('../database/conn')

const Authentication = require('../middleware/auth-jwt')

function getUserById(id) {
    return new Promise((resolve, reject) => {
        db.query('SELECT * FROM data_admin WHERE id_Admin = ?', [id], (err,result) => {
            if(err) {
                console.log(err)
            } else {
                var data = {
                    id: result[0].id_Admin,
                    email: result[0].email,
                    role: result[0].jabatan,
                    password: result[0].password,
                    id_mahasiswa: result[0].id_mahasiswa,
                    id_Acara: result[0].id_Acara,
                    id_Organisasi: result[0].id_Organisasi
                }
                resolve(data)
            }
        })
    })
}

function getUserByStudentId(NIM) {
    return new Promise((resolve, reject) => {
        db.query('SELECT * FROM data_admin WHERE id_mahasiswa = ?', [NIM], (err, result) => {
            if (result.length == 0) {
                resolve(null)
            } else {
                var data = {
                    id: result[0].id_Admin,
                    email: result[0].email,
                    role: result[0].jabatan,
                    password: result[0].password,
                    id_mahasiswa: result[0].id_mahasiswa,
                    id_Acara: result[0].id_Acara,
                    id_Organisasi: result[0].id_Organisasi
                }
                resolve(data)
            }
        })
    })
}

function initialize(passport) {
  const authenticateUser = async (NIM, password, done) => {
    const user = await getUserByStudentId(NIM)
    if (user == null) {
        return done(null, false, { message: 'Student Id Inccoret' })
    } else {         
        try {
            if (await bcrypt.compare(password, user.password)) {
                //to get AccesToken and RefreshToken
                //Authentication.getToken(user)

                return done(null, user)
            } else {
                return done(null, false, { message: 'Password Inccoret' })
            }
        } catch (e) {
            return done(e)
        }
    }
  }

  passport.use(new LocalStrategy({ usernameField: 'NIM' }, authenticateUser))
  passport.serializeUser((user, done) => done(null, user.id))
  passport.deserializeUser( (id, done) => {
    getUserById(id).then((result) => {
        return done(null, result)
    })
    //return done(null, getUserById(id))
  })
}

module.exports = initialize
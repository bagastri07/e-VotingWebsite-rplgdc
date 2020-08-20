const LocalStrategy = require('passport-local').Strategy
const bcrypt = require('bcrypt')
const db = require('../database/conn')
const con = require('../database/conn')

const admin = require('../database/superadmin');
const { use } = require('passport');

function getUserByIdPemilih(id) {
    return new Promise((resolve, reject) => {
        db.query('SELECT * FROM data_pemilih WHERE id_Pemilih = ?', [id], (err,result) => {
            if(err) {
                console.log(err)
            } else {
                db.query('SELECT nama_Mahasiswa FROM data_mahasiswa WHERE id_Mahasiswa = ?', [result[0].id_Mahasiswa], (err, result2) => {
                    if (err) {
                        console.log(err)
                    } else {
                        var data = {
                            id: result[0].id_Pemilih,
                            email: result[0].email,
                            nama: result2[0].nama_Mahasiswa,
                            role: 'voter',
                            status_Token: result[0].status_token,
                            id_mahasiswa: result[0].id_Mahasiswa,
                            id_acara: result[0].id_acara,
                            Id_Paslon_Pilihan: result[0].Id_Paslon_Pilihan
                        }
                        resolve(data)
                    }
                })
            }
        })
    })
}

function getUserByStudentId(NIM) {
    return new Promise((resolve, reject) => {
        db.query('SELECT * FROM data_pemilih WHERE id_mahasiswa = ?', [NIM], (err, result) => {
            if (result.length == 0) {
                resolve(null)
            } else {
                resolve(result)
            }
        })
    })
}

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
  const authenticateUser1 = async (NIM, token, done) => {
    const user = await getUserByStudentId(NIM)
    if (user == null) {
        return done(null, false, { message: 'Student Id Inccoret' })
    } else {         
        try {
            for (let i = 0; i < user.length; i++) {
                if (await bcrypt.compare(token, user[i].Token)) {
                    var data = {
                        id: user[i].id_Pemilih,
                        email: user[i].email,
                        role: 'voter',
                        status_Token: user[i].status_token,
                        id_mahasiswa: user[i].id_Mahasiswa,
                        id_acara: user[i].id_acara,
                        Id_Paslon_Pilihan: user[i].Id_Paslon_Pilihan
                    }
                    if (data.status_Token === 'used') {
                        return done (null, false, {message: 'Your Token is Expired'})
                    } else {
                        return done(null, data)
                    }
                }
            }
            return done(null, false, { message: 'Token Inccoret' })
            
        } catch (e) {
            return done(e)
        }
    }
  }
  const authenticateUser2 = (username, password, done) => {
    const user = getSuperAdminByUsername(username)
    // console.log(user)
    if (user == null) {
        return done(null, false, { message: 'username incorrect' })
    } else {
        if (password == user.password) {
            let dataUser = {
                id: user.id,
                username: user.username,
                role: user.role
            }
            return done(null, dataUser)
        } else {
            return done(null, false, {message: 'password incorrect'})
        }
  }

  
}
    passport.use('superadmin', new LocalStrategy({ usernameField: 'username' }, authenticateUser2))
    passport.use('voter' , new LocalStrategy({ usernameField: 'NIM', passwordField: 'token' }, authenticateUser1))
    passport.serializeUser(function (user, done) {
        if(user.role !== 'superadmin') {
            let Voter = {
                id: user.id,
                role: 'voter'
            }
            return done(null, Voter)
        } 
        if(user.role === 'superadmin') {
           let admin = {
               id: user.id,
               role: 'superadmin'
           }
            return done(null, admin)
        } 
    })
    passport.deserializeUser( async (User, done) => {
        if (User.role == 'superadmin') {
            let user = await getSuperAdminById(User.id)
            return done(null, user)
        } 

        if (User.role == 'voter') {
            let user = await getUserByIdPemilih(User.id)
            return done(null, user)
        }
      
     })
}

module.exports = initialize
const db = require('../database/conn')
const jwt = require('jsonwebtoken')

exports.getToken = (user) => {
    return new Promise((resolve, reject) => {
        user = {
            email: user.email,
            role: user.role
        }
    
        const accessToken = generateAccesToken(user)
        const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_JWT)
        
        //It's should be store on the database
        let queryString = 'INSERT INTO data_refreshtoken SET ?'
        db.query(queryString, {refreshToken: refreshToken}, (err, results) => {
            if (err) {
                throw err
            }
        })
        var data = {
            accessToken: accessToken,
            refreshToken: refreshToken
        }
        resolve(data)
    })
}

function generateAccesToken(user) {
    return jwt.sign(user, process.env.ACCESS_TOKEN_JWT, {expiresIn: '400s'})
}
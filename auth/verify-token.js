const jwt = require('jsonwebtoken')
const con = require('../database/conn')

exports.role = (role) => {
  return (req, res, next) => {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]
    if (token == null) return res.sendStatus(401)
  
    jwt.verify(token, process.env.ACCESS_TOKEN_JWT, (err, user) => {
      if (err) {
        //console.log(err)
        return res.sendStatus(403)
      }
      req.token = user
      if (req.token.role == role || role === 'ALL') {
        return next()
      } else{
        return res.sendStatus(403)
      }
    })
  }
}





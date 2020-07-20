const express = require('express')
const router = express.Router()
const jwt = require('jsonwebtoken')
const db = require('../../database/conn')

function generateAccesToken(user) {
    return jwt.sign(user, process.env.ACCESS_TOKEN_JWT, {expiresIn: '400s'})
}

function getRefreshToken(token) {
    return new Promise((resolve, reject) => {
        db.query('SELECT * FROM data_refreshtoken WHERE refreshToken = ?', [token], (err,result) => {
            if(err) {
                console.log(err)
            } else {
                if(result.length == 0) {
                    resolve(null)
                } else {
                    resolve(result[0].refreshToken)
                }
            }
        })
    })
}

router.post('/token', async (req, res) => {
    const refreshToken = req.body.token
    const searchRefreshToken = await getRefreshToken(refreshToken)
    if (refreshToken == null) return res.sendStatus(401)
    if (searchRefreshToken == null) return res.sendStatus(403)

    jwt.verify(refreshToken, process.env.REFRESH_TOKEN_JWT, (err, user) => {
        if (err) {
            console.log(err)
            return res.sendStatus(403)
        }
        const accessToken = generateAccesToken({user: user.email, role: user.role})
        res.json({accessToken: accessToken})
    })
})

router.delete('/logout', (req, res) => {
    //delete the refresh token on the database
    localStorage.setItem
    let token = req.body.token
    let queryString = 'DELETE From data_refreshtoken WHERE refreshToken = ?'
    db.query(queryString, [token], (err, results) => {
        if (err) {
            res.json({status : err})
        } else {
            res.json({
                'Row Affected': results.affectedRows,
                msg : "DELETE Success"
            })
        }

    })
})

router.post('/login', (req, res) => {
    const email = req.body.email
    const role = req.body.role
    user = {
        email: email,
        role: role
    }

    const accessToken = generateAccesToken(user)
    const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_JWT)
    
    //It's should be store on the database
    let queryString = 'INSERT INTO data_refreshtoken SET ?'
    db.query(queryString, {refreshToken: refreshToken}, (err, results) => {
        if (err) {
            res.json({status : err})
        } else {
            res.json({
                'row affected': results.affectedRows,
                msg : "POST Success",
                accessToken: accessToken,
                refreshToken: refreshToken

            })
        }
    })
})


module.exports = router
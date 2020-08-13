const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')
const session = require('express-session')
const flash = require('express-flash')
const passport = require('passport')

//Port we gonna use
const port = 8888

if (process.env.NODE_ENV !== 'production') {
    require('dotenv').config()
  }

app.set('view engine', 'ejs')
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))
app.use(cookieParser())

//express session config
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: {
        maxAge: 2 * 60 * 60 * 1000
    }
}))

//passport middleware
app.use(passport.initialize())
app.use(passport.session())

//connect flash
app.use(flash())

//set Static File
app.use(express.static(__dirname + '/public'))

//for the all pages route 
app.use('/', require('./routes/Pages/voter')) 
app.use('/super', require('./routes/Pages/superadmin'))
app.use('/api', require('./routes/API/api-config'))
app.use('/auth/sa', require('./auth/auth-superadmin-jwt-config'))

app.listen(port, () => {
    console.log('Server is running on port: ' + port)
})
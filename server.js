const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const session = require('express-session')
const flash = require('express-flash')
const passport = require('passport')
const subdomain = require('express-subdomain')

//Port we gonna use
const port = 8888

if (process.env.NODE_ENV !== 'production') {
    require('dotenv').config()
  }

app.set('view engine', 'ejs')
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))

//express session config
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: {
        maxAge: 60 * 1000
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
//app.use(subdomain('/admin', require('./routes/Pages/admin')))
app.use('/', require('./routes/Pages/voter')) 
app.use('/sa', require('./routes/Pages/superadmin'))
app.use('/adm', require('./routes/Pages/admin'))
app.use('/API', require('./routes/API/api-config'))

app.listen(port, () => {
    console.log('Server is running on port: ' + port)
})
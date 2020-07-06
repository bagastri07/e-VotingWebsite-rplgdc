const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const path = require('path')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))

const publicDirectory = path.join(__dirname, './public')
app.use(express.static(publicDirectory))

app.set('view engine', 'ejs')


//for the all pages route
app.use('/', require('./routes/pages/pages')) 
app.use('/auth', require('./routes/auth')) 
app.use('/API', require('./routes/API/api-config'))

app.listen(8888, () => {
    console.log('Server is running on port 8888')
})
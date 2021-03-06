const mysql = require('mysql')

const db_config = {
    host: process.env.DATABASE_HOST,
    user: process.env.DATABASE_USER,
    password: process.env.DATABASE_PWD,
    database: process.env.DATABASE
}

var con = mysql.createConnection(db_config)

con.connect((err) => {
    if(err) {
        console.log('error connecting to database:' + err.stack)
    } else {
        console.log('Connected as id ' + con.threadId)
    }
})

// con.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
//     if (error) throw error;
//     console.log('The solution is: ', results[0].solution);
//   });

module.exports = con
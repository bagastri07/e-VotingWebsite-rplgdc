const admin = {
    id: Date.now().toString() ,
    username: process.env.SUPERADMIN_USERNAME,
    password: process.env.SUPERADMIN_PASSWORD
    }

module.exports = admin
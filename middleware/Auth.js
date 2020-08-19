exports.role = (role, domain) => {
    return (req, res, next) => {
        if (!req.user) {
            return res.redirect(domain)
        }
        if (req.user.role == role) {
            return next()
        } else {
            //console.log(req.user)
            if (req.user.role === 'superadmin') {
                return res.redirect('/super/dashboard')
            } else {
                return res.redirect('/dashboard')
            }

        }
    }
  }

exports.isLogin = (domain) => {
    return (req, res, next) => {
        if (!req.user) {
            return next()
        }
        return res.redirect(domain)
    }
}
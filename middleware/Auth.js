exports.role = (role, domain) => {
    return (req, res, next) => {
        if (!req.user) {
            return res.redirect(domain)
        }
        if (req.user.role == role) {
            return next()
        } else {
            console.log(req.user)
            res.redirect(domain)
        }
    }
  }

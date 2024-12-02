const sestion = require('node-sessionstorage');
module.exports = function(req, res, next) {
    let check = sestion.getItem('admin_login') ? true : false;
    res.locals.userName = sestion.getItem('admin_login');
    if (check) {
        next();
    } else {
        res.redirect('/login');
    }
}
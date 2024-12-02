const db = require('../connect');
const sestion = require('node-sessionstorage');
module.exports = function(server) {

    server.get('/login', function (req, res) {
        res.render('login', {message: null})
    })


    server.post('/login', function (req, res) {
        let Sql = "SELECT * FROM account WHERE email = ? AND password = ?";
        db.query(Sql, [req.body.email, req.body.password], function (err, data) {
            if (!err && data.length > 0) {
                if (data[0].role != 'admin') {
                    res.render('login', {
                        message: 'Bạn không có quyền truy cập trang quản trị'
                    });
                } else {
                    sestion.setItem('admin_login', data[0].name);
                    res.redirect('/');
                }
               
            } else {
                res.render('login', {
                    message: 'Thông tin tài khoản không chính xác'
                });
            }
        });
    })

}
const db = require('../connect');
module.exports = function (server) {

    server.get('/account', function (req, res) {
        db.query("SELECT * FROM account", function (err, data) {
            res.render('account', {
                data: data,
            })
        });
    })

    server.get('/delete-account/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "DELETE FROM account WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            if (!err) {
                res.redirect('/account');
            }
        });
    })

    server.get('/create-account', function (req, res) {
        res.render('create-account');
    })

    server.post('/create-account', function (req, res) {
        let formData = req.body;
        let Sql = "INSERT INTO account SET ?";
        db.query(Sql, [formData], function (err, data) {
            if (!err) {
                res.redirect('/login');
            }
        });
    })

    server.get('/edit-account/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "SELECT * FROM account WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            let cat = null;
            if (data.length > 0) {
                data = data[0];
            }
            res.render('edit-account', {
                data: cat
            });
        });

    })

    server.post('/edit-account/:id', function (req, res) {
        let formData = req.body;
        let id = req.params.id;
        let Sql = "UPDATE account SET ? WHERE id = ?";
        db.query(Sql, [formData, id], function (err, data) {
            if (!err) {
                res.redirect('/account');
            }
        });
    })
}
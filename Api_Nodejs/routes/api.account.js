const db = require('../connect');
module.exports = function (server) {

    server.post('/api/register', function (req, res) {
        let formData = req.body;
        let Sql = "INSERT INTO account SET ?";
        db.query(Sql, [formData], function (err, data) {
            if (err) {
                res.send({
                    result: "Email " + formData.email + " Đã tồn tại",
                    status: false
                })
            } else {
                formData.id = data.insertId;
                res.send({
                    result: formData,
                    status: true
                })
            }
        });
    })

    server.put('/api/account/:id', function (req, res) {
        let formData = req.body;
        let id = req.params.id;
        let Sql = "UPDATE account SET ? WHERE id = ?";
        db.query(Sql, [formData, id], function (err, data) {
            if (err) {
                res.send({
                    account: false
                })
            } else {
                res.send({
                    account: data
                })
            }
        });
    })

    server.post('/api/login', function (req, res) {
        let Sql = "SELECT * FROM account WHERE email = ? AND password = ?";
        db.query(Sql, [req.body.email, req.body.password], function (err, data) {

            res.send({
                result: data.length ? data[0] : null
            })
        });
    })

    server.get('/api/account/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "SELECT * FROM account WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            res.send({
                account: data.length ? data[0] : null
            })
        });
    })

}
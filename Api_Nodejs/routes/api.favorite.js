const db = require('../connect');
module.exports = function (server) {

    server.get('/api/favorite/:acc_id/:pro_id', function (req, res) {
        let acc_id = req.params.acc_id;
        let pro_id = req.params.pro_id;
        let Sql = "SELECT * FROM favorite WHERE account_id = ? AND song_id = ?";

        db.query(Sql, [acc_id, pro_id], function (err, data) {
            res.send({
                status: data.length > 0 ? true : false
            })
        });
    })

    server.post('/api/favorite', function (req, res) {
        let formData = req.body; 
        // kiem tra va xoa da thic trươc dó
        let Sql = "SELECT * FROM favorite WHERE account_id = ? AND song_id = ?";
        db.query(Sql, [formData.account_id, formData.song_id], function (err, data) {
            if (data.length > 0) {
                let Sql1 = "DELETE FROM favorite WHERE account_id = ? AND song_id = ?";
                db.query(Sql1, [formData.account_id, formData.song_id], function (err, data) {
                    res.send({
                        result: 'Đã bỏ yêu thích'
                    })
                });
            } else {
                // thêm yêu thích mới nếu chưa có
                let Sql = "INSERT INTO favorite SET ?";
                db.query(Sql, [formData], function (err, data) {
                    res.send({
                        result: "Thêm yêu thích thành công"
                    })
                });
            }
        });

    })

    server.delete('/api/favorite/:acc_id/:pro_id', function (req, res) {
        let Sql = "DELETE FROM favorite WHERE account_id = ? AND song_id = ?";
        db.query(Sql, [req.params.acc_id, req.params.pro_id], function (err, data) {
            res.send({
                result: 'Bỏ thích thành công'
            })
        });
    })

    server.get('/api/favorite/:acc_id', function (req, res) {
        let acc_id = req.params.acc_id;
        let Sql = "SELECT f.*, p.* FROM favorite f JOIN product p ON f.song_id = p.id WHERE f.account_id = ?";
        db.query(Sql, [acc_id], function (err, data) {
            res.send({
                result: data
            })
        });
    })
   
}
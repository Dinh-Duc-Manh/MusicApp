const db = require('../connect');
module.exports = function (server) {

    server.get('/api/songs', function (req, res) {
        let SQL = "SELECT * FROM songs Order By id DESC";
        db.query(SQL, function (err, data) {
            res.send({
                songs: data
            })
        });
    })
    server.get('/api/songs2', function (req, res) {
        let SQL = "SELECT id,title,album,artist,source,image,duration FROM songs Order By id DESC";

        db.query(SQL, function (err, data) {
            res.send({
                songs: data
            })
        });
    })
    //
    server.get('/api/search-songs', function (req, res) {
        let key = req.query.key
        let SQL = "SELECT * FROM songs";
        if (key) {
            // "SELECT * FROM songs LIMIT 6";
            SQL += " WHERE name LIKE '%" + key +"%'"
        }

        SQL += ' Order By id DESC'
        db.query(SQL, function (err, data) {
            res.send({
                songs: data
            })
        });
    })

    server.get('/api/songs/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "SELECT * FROM songs WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            res.send({
                songs: data.length ? data[0] : null
            })
        });
    })
    //
    
    server.put('/api/songs/:id', function (req, res) {
        let formData = req.body;
        let id = req.params.id;
        let Sql = "UPDATE songs SET ? WHERE id = ?";
        db.query(Sql, [formData, id], function (err, data) {
            res.send({
                songs: data
            })
        });
    })
    
     server.post('/api/songs', function (req, res) {
         let formData = req.body;
         let Sql = "INSERT INTO songs SET ?";
         db.query(Sql, [formData], function (err, data) {
             res.send({
                 songs: data
             })
         });
     })

    server.delete('/api/songs/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "DELETE FROM songs WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            res.send({
                songs: data
            })
        });
    })

}
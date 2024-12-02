const { title } = require('ejs');
const db = require('../connect');
const upload = require('../moddleware/upload');
const upSongs = require('../moddleware/upSongs');
const multer = require('multer');
const util = require('node:util');
const _query = util.promisify(db.query).bind(db);
module.exports = function (server) {

    server.get('/songs', function (req, res) {
        Category.getAll(req, (err, data, _totalPage, _page, _title) => {
            res.render('songs', {
                data: data ? data : [],
                totalPage: _totalPage,
                page: parseInt(_page),
                title: _title
            });
        });
        // db.query("SELECT * FROM songs Order By id DESC", function (err, data) {
        //     res.render('songs', {
        //         data: data,
        //     })
        // });
    })
    const Category = function () { }
    Category.getAll = async function (req, callback) {
        let _title = req.query.title;
        let _page = req.query.page ? req.query.page : 1;
        let _sqlTotal = "SELECT COUNT(*) AS totalRow FROM songs";
        if (_title) {
            _sqlTotal += " WHERE title LIKE '%" + _title + "%'OR artist LIKE '%" + _title +"%'"
        }
        let _rowData = await _query(_sqlTotal);
        let _totalRow = _rowData[0].totalRow;
        let _limit = 5;
        let _totalPage = Math.ceil(_totalRow / _limit);
        _page = _page > 0 ? Math.floor(_page) : 1;
        _page = _page <= _totalPage ? Math.floor(_page) : _totalPage;
        let _start = (_page - 1) * _limit;
        let _sql = "SELECT * FROM songs";
        if (_title) {
            _sql += " WHERE title LIKE '%" + _title +"%' OR artist LIKE '%" + _title +"%'"
        }
        _sql += " Order By id DESC LIMIT " + _start + "," + _limit;
        db.query(_sql, (err, data) => {
            callback(err, data, _totalPage, _page, _title);
        });
    } 

    server.get('/search-songs', function (req, res) {
        let key = req.query.key
        let SQL = "SELECT * FROM songs";
        if (key) {
            SQL += " WHERE title LIKE '%" + key +"%' OR artist LIKE '%" + key +"%'"
        }
        SQL += ' Order By id DESC'
        db.query(SQL, function (err, data) {
            res.render('songs', {
                data: data,
            })
        });
    })

    server.get('/delete-songs/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "DELETE FROM songs WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            if (!err) {
                res.redirect('/songs');
            }
        });
    })

    server.get('/create-songs', function (req, res) {
        let Sql = "SELECT id, name FROM category Order By name ASC";
        db.query(Sql, function (err, data) {
            res.render('create-songs', {
                cats: data,
            })
        });
    })

    const storage = multer.diskStorage({
        destination: (req, file, cb) => {
            cb(null, './public/songs/');
        },
        filename: (req, file, cb) => {
            cb(null, file.fieldname + '-' + Date.now() + file.originalname.match(/\..*$/)[0]);
        }
    });

    const upload = multer({ storage: storage });

    server.post('/create-songs', upload.fields([{ name: 'source', maxCout: 1 }, { name: 'image', maxCout: 1 }]), function (req, res) {
        let formData = req.body;

        // if (req.fileS) {
        //     formData.source = req.fileS.filename2;
        // }
        try {
            formData.image = req.files['image'] ? req.files['image'][0].filename : null;
            formData.source = req.files['source'] ? req.files['source'][0].filename : null;


            let Sql = "INSERT INTO songs SET ?";
            db.query(Sql, [formData], function (err, data) {

                if (err) {
                    console.log(err);
                }
                else {
                    res.redirect('/songs');
                }
            });
        } catch (err) {
            res.status(400).send('Error uploading files.');
        }
    })

    server.get('/edit-songs/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "SELECT * FROM songs WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            let cat = null;
            if (data.length > 0) {
                cat = data[0];
            }
            res.render('edit-songs', {
                data: cat
            });
        });

    })

    server.post('/edit-songs/:id',upload.fields([{ name: 'source', maxCout: 1 }, { name: 'image', maxCout: 1 }]), function (req, res) {
        let id = req.params.id;
        let duration = parseInt(req.body.duration);
        let formData = {
                title:req.body.title,
                album:req.body.album,
                artist:req.body.artist,
                source:req.body.source2,
                image:req.body.image2,
                duration:duration,
        };
        req.body;
        formData.image = req.files['image'] ? req.files['image'][0].filename : req.body.image2;
        formData.source = req.files['source'] ? req.files['source'][0].filename : req.body.source2;
        let Sql = "UPDATE songs SET ? WHERE id = ?";
        db.query(Sql, [formData, id], function (err, data) {
            if (!err) {
                res.redirect('/songs');
            }
        });
    })
    
}
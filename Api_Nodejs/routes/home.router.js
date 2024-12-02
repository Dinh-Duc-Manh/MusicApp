const db = require('../connect');
const sestion = require('node-sessionstorage');
module.exports = function(server) {

    server.get('/', function (req, res) {
        res.render('home')
    });
    
    
    server.get('/about', function (req, res) {
        res.render('about')
    })

    
        
    server.get('/logout', function (req, res) {
        sestion.removeItem('admin_login');
        res.redirect('/login');
    })


}
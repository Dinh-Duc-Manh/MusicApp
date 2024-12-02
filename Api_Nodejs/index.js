const express = require('express');
const server = express();

const ejs = require('ejs');
const bodyParser = require('body-parser');
const session = require('node-sessionstorage');
server.set('view engine', 'ejs');
server.use(bodyParser.json());
server.use(bodyParser.urlencoded({ extended: true }));
server.use(express.static('public'));

// tạo các route

require('./routes/account.router')(server);
const auth = require('./moddleware/auth');
const cors = require('cors');
// api router
var corsOptions = {
    origin: '*',
    optionsSuccessStatus: 200 // For legacy browser support
}
server.use(cors(corsOptions));
server.locals.user = session.getItem()

require('./routes/api.songs')(server);
require('./routes/api.account')(server);
require('./routes/api.favorite')(server);
require('./routes/login.router')(server);
server.use(auth);
require('./routes/songs.router')(server);
require('./routes/home.router')(server);
require('./routes/songs.router')(server);

server.listen(3100, function(){
        console.log("http://localhost:3100");
})
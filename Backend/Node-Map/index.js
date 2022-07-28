const express = require('express');
const http = require('http');
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const cors = require('cors');
const helmet = require('helmet');
var useragent = require('express-useragent');
var path = require('path');

//route inititializations


//const sajanRoutes = require('./routes/sajanRoutes')
//const roomRoutes=require('./routes/roomRoutes')
const reviewRoute=require('./routes/reviewRoute')

var app = express();
app.use(cors());
app.use(helmet());
app.options('*', cors());

var server = http.createServer(app);

const port = process.env.PORT ||5001;

mongoose.Promise = global.Promise;
//live
mongoose.connect('mongodb+srv://pappykunj:Angela123@cluster0.avfy4.mongodb.net/SpeedLimiter?retryWrites=true&w=majority',

    { useNewUrlParser: true, useUnifiedTopology: true }).then(() => {
        console.log("DataBase connected.");
        console.log("Fetched Live Data.")
    },
        err => {
            console.log("db connection error");
            console.log(err)
        });





app.use(function (req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
    res.setHeader('Access-Control-Allow-Credentials', true);
    next();
});

//middleware
app.use(function (req, res, next) {
    var fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
    console.log(fullUrl)
    next();
})
app.use(bodyParser.json({ limit: '150mb' }));
app.use(bodyParser.urlencoded({ extended: true, limit: '150mb' }));
app.set('view engine', 'ejs');

app.get('/u/:id', (req, res) => {
    s3.readFile(res, req.params.id)
    return;
});
app.get('/wp/:id', (req, res) => {
    if (req.params.id) {
        if (path.extname(req.params.id) === ".svg") {
            s3.readFile(res, req.params.id)
            return;
        }
    }

    s3.readFile(res, ('wp_' + req.params.id + ".webp"))
    return;
});

//app.use


app.get('/health', async (req, res) => {
    res.send({
        status: true,
        d: Date.now(),
        msg: "Use API end point!"
    });
    res.end();
});

// app.use(sajanRoutes)
// app.use(roomRoutes)
app.use(reviewRoute)

server.listen(port, () => {
    console.log(`Server with ws capability running on port ${port}`);
    console.log("Database Connection Initiated")
});
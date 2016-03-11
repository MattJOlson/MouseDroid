var express = require('express');
var routes = require('./src/routes.js');
var bodyParser = require('body-parser');
var app = express();
app.use(bodyParser.json());

/*
    var cache = require('memory-cache');
    var val = cache.get(req.params.string);

    if(val) {
        res.end('Already seen ' + val + ' within 25s');
    } else {
        cache.put(req.params.string, req.params.string, 25000);
        res.end(req.method + ' ' + req.path);
    }
*/

routes(app, null);

app.listen(3000, function() {
    console.log('Listening on port 3000');
});

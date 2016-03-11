var express = require('express');
var router = express.Router();
var fs = require('fs');
var path = require('path');

module.exports = function (app, addon) {
    app.get('/health', function (req, res) {
        res.send('OK');
    });

    app.get('/', function (req, res) {
        fs.readFile(path.normalize('./addon.json'), 'utf-8',
                                   function(err, data) {
            if(err) {
                res.sendStatus(404);
            }
            res.send(data);
        });
    });

    function makeResponse(mention, msg) {
        return JSON.stringify({
            "color": "grey",
            "notify": "false",
            "message_format": "text",
            "message": "Beep boop! Hi @" + mention + ", you said " + msg
        }, null, 2);
    };

    app.post('/hook', function (req, res) {
        console.log(JSON.stringify(req.body, null, 2));
        res.setHeader('Content-Type', 'text/plain');
        res.end(makeResponse(req.body.item.message.from.mention_name,
                             req.body.item.message.message));
    });

    /*
    app.post('/webhook',
        addon.authenticate(),
        function (req, res) {
            hipchat.sendMessage(req.clientInfo, req.identity.roomId, 'Beep boop')
                .then(function(data) {
                    res.sendStatus(200);
                });
        });
        */
};

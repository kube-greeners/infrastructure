var express = require('express');
var router = express.Router();

var buffers = [];

router.get('/', (req, res) => {
    res.send(JSON.stringify({"Hello": "World"}));
});

router.get("/increase", (req, res) => {
    let arr = [];
    for (let i = 0; i < 1024 * 1024 * 4; i++) {
        arr[arr.length] = Math.random();
    }
    buffers[buffers.length] = arr;

    res.send(`${buffers.length} Buckets`);
});

router.get("/decrease", (req, res) => {
    if (buffers.length) {
        buffers.length -= 1;
    }

    res.send(`${buffers.length} Buckets`);
});


module.exports = router;

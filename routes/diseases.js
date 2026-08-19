const express = require("express");

const router = express.Router();

router.get("/", (req, res) => {

    res.send("Disease Library Module Ready");

});

module.exports = router;

const express = require("express");

const router = express.Router();

router.get("/", (req, res) => {

    res.send("Training Module Ready");

});

module.exports = router;

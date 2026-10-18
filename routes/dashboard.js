const express = require("express");
const router = express.Router();
const { getDatabase } = require("../database/db");
const dashboard = require("../services/dashboard");
router.get("/", async (req, res, next) => {
    try {
        const db = await getDatabase();
        const stats = await dashboard.statistics(db);
        res.render("dashboard", { stats });
    } catch (err) { next(err); }
});
module.exports = router;

const { getDatabase } = require("../database/db");
exports.list = async function(req, res, next) {
    try {
        const db = await getDatabase();
        const result = await db.query("SELECT id, fullname, institution, speciality, country FROM researchers ORDER BY fullname");
        const researchers = result.rows.map(r => [r.id, r.fullname, r.institution, r.speciality, r.country]);
        res.render("researchers/index", { researchers });
    } catch (err) { next(err); }
};
exports.addForm = function(req, res) { res.render("researchers/add"); };
exports.add = async function(req, res, next) {
    try {
        const db = await getDatabase();
        const { fullname, institution, department, email, phone, orcid, speciality, country, biography } = req.body;
        await db.query(`INSERT INTO researchers (fullname, institution, department, email, phone, orcid, speciality, country, biography, created_at) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,CURRENT_TIMESTAMP)`, [fullname, institution, department, email, phone, orcid, speciality, country, biography]);
        res.redirect("/researchers");
    } catch (err) { next(err); }
};

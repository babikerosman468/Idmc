const { getDatabase } = require("../database/db");
exports.search = async function(req, res, next) {
    try {
        const db = await getDatabase();
        const keyword = (req.query.q || "").trim();
        let projects = [], publications = [], researchers = [];
        if (keyword) {
            const term = `%${keyword}%`;
            const results = await Promise.all([
                db.query("SELECT id, title, year FROM projects WHERE title ILIKE $1 ORDER BY year DESC", [term]),
                db.query("SELECT id, title FROM publications WHERE title ILIKE $1 ORDER BY year DESC", [term]),
                db.query("SELECT id, fullname FROM researchers WHERE fullname ILIKE $1 ORDER BY fullname", [term])
            ]);
            projects = results[0].rows.map(r => [r.id, r.title, r.year]);
            publications = results[1].rows.map(r => [r.id, r.title]);
            researchers = results[2].rows.map(r => [r.id, r.fullname]);
        }
        res.render("search/index", { keyword, projects, publications, researchers });
    } catch (err) { next(err); }
};

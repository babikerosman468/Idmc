exports.statistics = async function(db) {
    const tables = ["projects", "publications", "researchers", "users", "diseases", "datasets", "courses"];
    const counts = await Promise.all(tables.map(async table => {
        const result = await db.query(`SELECT COUNT(*)::int AS total FROM ${table}`);
        return [table, result.rows[0].total];
    }));
    async function latest(table, column) {
        const result = await db.query(`SELECT ${column} FROM ${table} ORDER BY id DESC LIMIT 1`);
        return result.rows.length ? (result.rows[0][column] || "None") : "None";
    }
    const [latestProject, latestPublication, latestResearcher] = await Promise.all([
        latest("projects", "title"), latest("publications", "title"), latest("researchers", "fullname")
    ]);
    return { ...Object.fromEntries(counts.map(([key, value]) => [key, value])), latestProject, latestPublication, latestResearcher };
};

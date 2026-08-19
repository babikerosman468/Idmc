const initSqlJs = require("sql.js");
const fs = require("fs");
const path = require("path");

const dbFile = path.join(__dirname, "idmc.db");

let db;

async function getDatabase() {

    const SQL = await initSqlJs();

    if (fs.existsSync(dbFile)) {

        const buffer = fs.readFileSync(dbFile);

        db = new SQL.Database(buffer);

    } else {

        db = new SQL.Database();

    }

    return db;
}


async function saveDatabase() {

    const data = db.export();

    fs.writeFileSync(
        dbFile,
        Buffer.from(data)
    );

}


module.exports = {
    getDatabase,
    saveDatabase
};

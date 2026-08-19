const initSqlJs = require("sql.js");
const fs = require("fs");
const path = require("path");

const dbFile = path.join(__dirname, "idmc.db");

let db = null;


async function getDatabase() {

    if (db) {
        return db;
    }


    const SQL = await initSqlJs();


    if (fs.existsSync(dbFile)) {

        const buffer = fs.readFileSync(dbFile);

        db = new SQL.Database(buffer);

        console.log("IDMC database loaded");

    } else {

        db = new SQL.Database();

        console.log("New IDMC database created");

    }


    return db;

}



function saveDatabase() {

    if (!db) return;


    const data = db.export();

    fs.writeFileSync(
        dbFile,
        Buffer.from(data)
    );

    console.log("Database saved");

}



module.exports = {
    getDatabase,
    saveDatabase
};

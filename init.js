const { getDatabase, saveDatabase } = require("./db");


async function init() {


    const db = await getDatabase();


    db.run(`
    CREATE TABLE IF NOT EXISTS users (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        username TEXT UNIQUE,

        password TEXT,

        role TEXT DEFAULT 'user'

    )
    `);



    db.run(`
    CREATE TABLE IF NOT EXISTS projects (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        title TEXT,

        description TEXT,

        year INTEGER

    )
    `);



    db.run(`
    CREATE TABLE IF NOT EXISTS publications (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        title TEXT,

        authors TEXT,

        year INTEGER

    )
    `);



    saveDatabase();


    console.log("IDMC database initialized");

}


init();

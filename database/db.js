const { Pool } = require("pg");
const fs = require("fs");
const path = require("path");

require("dotenv").config({
    path: path.join(__dirname, "../.env.neon"),
    override: false
});

if (!process.env.DATABASE_URL) {
    throw new Error("DATABASE_URL is not configured");
}

const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: { rejectUnauthorized: false },
    max: 5,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 10000
});

pool.on("error", err => {
    console.error("Unexpected PostgreSQL pool error:", err.message);
});

async function getDatabase() {
    return pool;
}

async function saveDatabase() {
    // PostgreSQL persists committed changes automatically.
}

module.exports = {
    pool,
    query: (text, params) => pool.query(text, params),
    getDatabase,
    saveDatabase
};

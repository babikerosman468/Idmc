require("dotenv").config();

const express = require("express");
const helmet = require("helmet");
const cors = require("cors");
const morgan = require("morgan");
const cookieParser = require("cookie-parser");
const session = require("express-session");
const path = require("path");


const bcrypt = require("bcryptjs");

const {
    getDatabase,
    saveDatabase
} = require("./database/db");


const projectRoutes = require("./routes/projects");
const auth = require("./middleware/auth");

const dashboardRoutes = require("./routes/dashboard");

const app = express();
app.set("trust proxy", 1);

let database;

(async () => {

    database = await getDatabase();

    console.log("IDMC database ready");

})();

app.disable("x-powered-by");

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

const PORT = process.env.PORT || 3000;

const SESSION_SECRET =
    process.env.SESSION_SECRET || "change_this_in_production";


/* ======================================================
   Middleware
====================================================== */

app.use(helmet());

app.use(cors({
    origin: true,
    credentials: true
}));

app.use(morgan("dev"));

app.use(express.json());

app.use(express.urlencoded({ extended: true }));

app.use(cookieParser());

app.use(session({
    secret: SESSION_SECRET,
    resave: false,
    saveUninitialized: false,

cookie: {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    maxAge: 24 * 60 * 60 * 1000
}
}));

app.use(express.static(path.join(__dirname, "public")));


/* ======================================================
   Health Check
====================================================== */



/* ======================================================
   Home Page
====================================================== */

app.get("/", (req,res)=>{
    res.redirect("/dashboard");
});


/* ======================================================
   Home Page
====================================================== */

app.get("/", (req, res) => {

    res.render("index");

});

app.use("/dashboard", dashboardRoutes);
/* ======================================================
   Routes
====================================================== */

app.get("/about", (req, res) => {

    res.render("about");

});


app.get("/research", (req, res) => {

    res.render("research");

});


app.get("/diseases", (req, res) => {

    res.render("diseases");

});

app.get("/login", (req, res) => {
    res.render("login");
});

app.post("/login", async (req, res) => {

    const { username, password } = req.body;

    if (username === process.env.ADMIN_USERNAME && password && process.env.ADMIN_PASSWORD_HASH && await bcrypt.compare(password, process.env.ADMIN_PASSWORD_HASH)) {

        req.session.user = {
            username: process.env.ADMIN_USERNAME,
            role: "admin"
        };

        return res.redirect("/admin");
    }

    res.send("Invalid username or password");
});



app.post("/logout", (req, res) => {
req.session.destroy((err) => {
if (err) {
console.error("Logout error:", err.message);
return res.status(500).send("Unable to log out");
}

    res.clearCookie("connect.sid");
    res.redirect("/login");
});

});
app.get("/admin", (req, res) => {

    if (!req.session.user) {
        return res.redirect("/login");
    }

    res.render("admin");
});


app.get("/database-test", async (req, res) => {
    try {
        const db = await getDatabase();
        
        const result = await db.query("SELECT tablename AS name FROM pg_tables WHERE schemaname = $1 ORDER BY tablename", ["public"]);

        res.json(result.rows);

    } catch (err) {
        console.error("Database test failed:", err.message);

        res.status(500).json({ error: "Database test failed" });

    }
});


/* Research Projects — PostgreSQL */

app.get("/projects", async (req, res) => {
    try {
        const db = await getDatabase();
        const r = await db.query("SELECT * FROM projects ORDER BY year DESC");
res.render("projects", { projects: r.rows, currentUser: req.session.user || null });
    } catch (e) {
        console.error("Projects:", e.message);
        res.status(500).send("Unable to load projects");
    }
});

app.get("/projects/add", auth, (req, res) => {
    res.render("add-project");
});

app.post("/projects/save", auth, async (req, res) => {
    try {
        const db = await getDatabase();
        const { title, description, year } = req.body;
        await db.query(
            "INSERT INTO projects (title, description, year) VALUES ($1, $2, $3)",
            [title, description, year ? Number(year) : null]
        );
        res.redirect("/projects");
    } catch (e) {
        console.error("Save project:", e.message);
        res.status(500).send("Unable to save project");
    }
});


app.get("/projects/edit/:id", auth, async (req, res) => {
    try {
        const db = await getDatabase();
        const r = await db.query(
            "SELECT * FROM projects WHERE id = $1",
            [req.params.id]
        );

        if (!r.rows.length) return res.status(404).send("Project not found");

        res.render("edit-project", { project: r.rows[0] });
    } catch (e) {
        console.error("Edit project:", e.message);
        res.status(500).send("Unable to load project");
    }
});

app.post("/projects/update/:id", auth, async (req, res) => {
    try {
        const db = await getDatabase();
        const { title, description, year } = req.body;

        await db.query(
            "UPDATE projects SET title = $1, description = $2, year = $3 WHERE id = $4",
            [title, description, year ? Number(year) : null, req.params.id]
        );

        res.redirect("/projects");
    } catch (e) {
        console.error("Update project:", e.message);
        res.status(500).send("Unable to update project");
    }
});

app.post("/projects/delete/:id", auth, async (req, res) => {
    try {
        const db = await getDatabase();

        await db.query(
            "DELETE FROM projects WHERE id = $1",
            [req.params.id]
        );

        res.redirect("/projects");
    } catch (e) {
        console.error("Delete project:", e.message);
        res.status(500).send("Unable to delete project");
    }
});
/* Publications — PostgreSQL */

app.get("/publications", async (req, res) => {
    try {
        const db = await getDatabase();
        const r = await db.query("SELECT * FROM publications ORDER BY year DESC");
res.render("publications", { publications: r.rows, currentUser: req.session.user || null });
    } catch (e) {
        console.error("Publications:", e.message);
        res.status(500).send("Unable to load publications");
    }
});

app.get("/publications/add", auth, (req, res) => {
    res.render("add-publication");
});

app.post("/publications/save", auth, async (req, res) => {
    try {
        const db = await getDatabase();
        const { title, authors, year } = req.body;
        await db.query(
            "INSERT INTO publications (title, authors, year) VALUES ($1, $2, $3)",
            [title, authors, year ? Number(year) : null]
        );
        res.redirect("/publications");
    } catch (e) {
        console.error("Save publication:", e.message);
        res.status(500).send("Unable to save publication");
    }
});

app.use("/projects", projectRoutes);

app.use("/search", require("./routes/search"));



/* ======================================================
   404
====================================================== */

app.use((req, res) => {

    res.status(404).render("404");

});


/* ======================================================
   Start Server
====================================================== */


if (require.main === module) {
    app.listen(PORT, () => {

        console.log("");
        console.log("===================================");
        console.log(" IDMC Version 14");
        console.log(" Running on Port " + PORT);
        console.log("===================================");
        console.log("");

    });
}

module.exports = app;


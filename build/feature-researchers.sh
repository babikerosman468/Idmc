#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " IDMC V15.1 Researcher Module"
echo "======================================"

mkdir -p views/researchers
mkdir -p uploads/researchers

echo "Creating researcher database migration..."

cat > database/researchers-migration.js <<'EOF'

const { getDatabase } = require("./db");

async function migrate(){

const db = await getDatabase();

await db.exec(`

CREATE TABLE IF NOT EXISTS researchers (

id INTEGER PRIMARY KEY AUTOINCREMENT,

name TEXT NOT NULL,

institution TEXT,

department TEXT,

country TEXT,

email TEXT,

orcid TEXT,

googleScholar TEXT,

researchGate TEXT,

expertise TEXT,

biography TEXT,

photo TEXT,

cv TEXT,

created_at DATETIME DEFAULT CURRENT_TIMESTAMP

);

`);

console.log("Researchers table created");

}

migrate();

EOF


echo "Creating researcher controller..."

cat > controllers/ResearcherController.js <<'EOF'

const { getDatabase } = require("../database/db");


exports.list = async (req,res)=>{

const db = await getDatabase();

const result = await db.exec(
"SELECT * FROM researchers ORDER BY id DESC"
);

let researchers=[];

if(result.length)
researchers=result[0].values;

res.render("researchers/index",
{researchers});

};


exports.add = (req,res)=>{

res.render("researchers/add");

};


exports.save = async(req,res)=>{

const db = await getDatabase();

const {
name,
institution,
department,
country,
email,
orcid,
expertise,
biography
}=req.body;


await db.run(

`INSERT INTO researchers
(name,institution,department,country,email,orcid,expertise,biography)
VALUES(?,?,?,?,?,?,?,?)`,

[
name,
institution,
department,
country,
email,
orcid,
expertise,
biography
]

);


res.redirect("/researchers");

};

EOF


echo "Creating researcher route..."

cat > routes/researchers.js <<'EOF'

const express=require("express");

const router=express.Router();

const controller=require("../controllers/ResearcherController");


router.get("/",controller.list);

router.get("/add",controller.add);

router.post("/add",controller.save);


module.exports=router;

EOF


echo "Creating views..."

cat > views/researchers/index.ejs <<'EOF'

<h1>IDMC Researchers</h1>

<a href="/researchers/add">
Add Researcher
</a>

<ul>

<% researchers.forEach(r=>{ %>

<li>
<b><%= r[1] %></b>
<br>
<%= r[2] || "" %>
</li>

<% }) %>

</ul>

EOF


cat > views/researchers/add.ejs <<'EOF'

<h1>Add Researcher</h1>

<form method="POST" action="/researchers/add">

<input name="name" placeholder="Full Name">

<input name="institution" placeholder="Institution">

<input name="department" placeholder="Department">

<input name="country" placeholder="Country">

<input name="email" placeholder="Email">

<input name="orcid" placeholder="ORCID">

<input name="expertise" placeholder="Expertise">

<textarea name="biography"
placeholder="Biography"></textarea>


<button type="submit">
Save
</button>

</form>

EOF


echo ""
echo "Add to server.js:"
echo ""
echo 'const researcherRoutes=require("./routes/researchers");'
echo 'app.use("/researchers",researcherRoutes);'

echo ""
echo "======================================"
echo " V15.1 Researcher Module Installed"
echo "======================================"

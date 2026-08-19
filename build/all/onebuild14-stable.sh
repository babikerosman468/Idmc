#!/data/data/com.termux/files/usr/bin/bash

############################################################
#
# IDMC VERSION 14
#
# PART 1
#
############################################################

clear

echo "=============================================="
echo " IDMC VERSION 14"
echo " Scientific Research Platform"
echo " PART 1"
echo "=============================================="

DATE=$(date +"%Y%m%d_%H%M%S")

echo ""
echo "Creating backup..."

mkdir -p backup

############################################################
# Backup
############################################################

for f in server.js package.json
do

if [ -f "$f" ]; then
cp "$f" backup/${f}.${DATE}
fi

done

############################################################
# Directories
############################################################

echo ""
echo "Creating directory tree..."

mkdir -p controllers
mkdir -p middleware
mkdir -p middleware/auth
mkdir -p middleware/upload

mkdir -p models

mkdir -p routes

mkdir -p services

mkdir -p config

mkdir -p database

mkdir -p uploads

mkdir -p uploads/projects

mkdir -p uploads/publications

mkdir -p uploads/researchers

mkdir -p uploads/images

mkdir -p uploads/documents

mkdir -p uploads/datasets

mkdir -p logs

mkdir -p reports

mkdir -p reports/pdf

mkdir -p reports/excel

mkdir -p reports/latex

mkdir -p public

mkdir -p public/css

mkdir -p public/js

mkdir -p public/images

mkdir -p public/icons

mkdir -p views

mkdir -p views/layouts

mkdir -p views/partials

mkdir -p views/dashboard

mkdir -p views/projects

mkdir -p views/publications

mkdir -p views/researchers

mkdir -p views/diseases

mkdir -p views/training

mkdir -p views/admin

############################################################
# Config
############################################################

if [ ! -f config/version.js ]; then

cat > config/version.js <<'EOF'

module.exports={

version:"14.0",

name:"IDMC",

year:2026

};

EOF

fi

############################################################
# Logger
############################################################

if [ ! -f services/logger.js ]; then

cat > services/logger.js <<'EOF'

const fs=require("fs");

exports.write=function(message){

const now=new Date().toISOString();

fs.appendFileSync(

"logs/idmc.log",

now+" "+message+"\n"

);

}

EOF

fi

############################################################
# Authentication Middleware
############################################################

if [ ! -f middleware/auth/auth.js ]; then

cat > middleware/auth/auth.js <<'EOF'

module.exports=function(req,res,next){

if(req.session && req.session.user){

return next();

}

return res.redirect("/login");

}

EOF

fi

############################################################
# Upload Middleware Placeholder
############################################################

if [ ! -f middleware/upload/upload.js ]; then

cat > middleware/upload/upload.js <<'EOF'

module.exports=function(req,res,next){

next();

}

EOF

fi

############################################################
# Home Controller
############################################################

if [ ! -f controllers/HomeController.js ]; then

cat > controllers/HomeController.js <<'EOF'

exports.index=function(req,res){

res.redirect("/dashboard");

}

EOF

fi

############################################################
# Dashboard Controller
############################################################

cat > controllers/DashboardController.js <<'EOF'

const {getDatabase}=require("../database/db");

const dashboard=require("../services/dashboard");

exports.index=async function(req,res){

const db=await getDatabase();

const stats=

dashboard.statistics(db);

res.render("dashboard",{

stats

});

}

EOF

############################################################

echo ""
echo "Controllers"

ls controllers

echo ""

echo "Services"

ls services

echo ""

echo "Directories created successfully."

echo ""

echo "========== END OF PART 1 =========="

############################################################
#
# IDMC VERSION 14
#
# PART 2
#
# Database Migration
#
############################################################

echo ""
echo "=============================================="
echo " PART 2"
echo " Database Migration"
echo "=============================================="

############################################################
# Database Migration Script
############################################################

cat > database/migrate.js <<'EOF'

const fs=require("fs");
const path=require("path");

const {getDatabase,saveDatabase}=require("./db");

async function migrate(){

const db=await getDatabase();

function exists(name){

const t=db.exec(
"SELECT name FROM sqlite_master WHERE type='table' AND name='"+name+"'"
);

return t.length>0;

}

////////////////////////////////////////////////////////////
// Researchers
////////////////////////////////////////////////////////////

if(!exists("researchers")){

db.run(`

CREATE TABLE researchers(

id INTEGER PRIMARY KEY AUTOINCREMENT,

fullname TEXT,

institution TEXT,

department TEXT,

email TEXT,

phone TEXT,

orcid TEXT,

speciality TEXT,

country TEXT,

biography TEXT,

created_at TEXT

);

`);

console.log("researchers created");

}

////////////////////////////////////////////////////////////
// Datasets
////////////////////////////////////////////////////////////

if(!exists("datasets")){

db.run(`

CREATE TABLE datasets(

id INTEGER PRIMARY KEY AUTOINCREMENT,

title TEXT,

description TEXT,

filename TEXT,

project_id INTEGER,

uploaded_at TEXT

);

`);

console.log("datasets created");

}

////////////////////////////////////////////////////////////
// Diseases
////////////////////////////////////////////////////////////

if(!exists("diseases")){

db.run(`

CREATE TABLE diseases(

id INTEGER PRIMARY KEY AUTOINCREMENT,

name TEXT,

category TEXT,

description TEXT,

symptoms TEXT,

transmission TEXT,

prevention TEXT

);

`);

console.log("diseases created");

}

////////////////////////////////////////////////////////////
// Training
////////////////////////////////////////////////////////////

if(!exists("courses")){

db.run(`

CREATE TABLE courses(

id INTEGER PRIMARY KEY AUTOINCREMENT,

title TEXT,

description TEXT,

instructor TEXT,

duration TEXT,

level TEXT

);

`);

console.log("courses created");

}

////////////////////////////////////////////////////////////
// Seed Diseases
////////////////////////////////////////////////////////////

const c=db.exec(
"SELECT COUNT(*) FROM diseases"
);

if(c[0].values[0][0]==0){

db.run("INSERT INTO diseases(name,category) VALUES('Malaria','Parasitic')");
db.run("INSERT INTO diseases(name,category) VALUES('Dengue','Viral')");
db.run("INSERT INTO diseases(name,category) VALUES('Tuberculosis','Bacterial')");
db.run("INSERT INTO diseases(name,category) VALUES('Cholera','Bacterial')");
db.run("INSERT INTO diseases(name,category) VALUES('COVID-19','Viral')");
db.run("INSERT INTO diseases(name,category) VALUES('Influenza','Viral')");
db.run("INSERT INTO diseases(name,category) VALUES('Mpox','Viral')");
db.run("INSERT INTO diseases(name,category) VALUES('Ebola','Viral')");

console.log("Sample diseases inserted");

}

saveDatabase(db);

console.log("");
console.log("Migration completed.");

}

migrate();

EOF

############################################################
# Researcher Model
############################################################

cat > models/Researcher.js <<'EOF'

class Researcher{

constructor(data){

Object.assign(this,data);

}

}

module.exports=Researcher;

EOF

############################################################
# Disease Model
############################################################

cat > models/Disease.js <<'EOF'

class Disease{

constructor(data){

Object.assign(this,data);

}

}

module.exports=Disease;

EOF

############################################################
# Dataset Model
############################################################

cat > models/Dataset.js <<'EOF'

class Dataset{

constructor(data){

Object.assign(this,data);

}

}

module.exports=Dataset;

EOF

############################################################
# Course Model
############################################################

cat > models/Course.js <<'EOF'

class Course{

constructor(data){

Object.assign(this,data);

}

}

module.exports=Course;

EOF

############################################################

echo ""
echo "Database migration created."

echo ""

echo "Run later using"

echo ""

echo "node database/migrate.js"

echo ""

echo "========== END OF PART 2 =========="

############################################################
#
# IDMC VERSION 14
#
# PART 3
#
# Live Dashboard Service
#
############################################################

echo ""
echo "=============================================="
echo " PART 3"
echo " Live Dashboard"
echo "=============================================="

############################################################
# Dashboard Service
############################################################

cat > services/dashboard.js <<'EOF'

exports.statistics=function(db){

function count(table){

try{

const r=db.exec(
"SELECT COUNT(*) FROM "+table
);

if(r.length){

return r[0].values[0][0];

}

}catch(e){}

return 0;

}

function latest(table,column){

try{

const r=db.exec(
"SELECT "+column+" FROM "+table+
" ORDER BY id DESC LIMIT 1"
);

if(r.length && r[0].values.length){

return r[0].values[0][0];

}

}catch(e){}

return "None";

}

return{

projects:count("projects"),

publications:count("publications"),

researchers:count("researchers"),

users:count("users"),

diseases:count("diseases"),

datasets:count("datasets"),

courses:count("courses"),

latestProject:
latest("projects","title"),

latestPublication:
latest("publications","title"),

latestResearcher:
latest("researchers","fullname")

};

}

EOF

############################################################
# Dashboard Route
############################################################

cat > routes/dashboard.js <<'EOF'

const express=require("express");

const router=express.Router();

const {getDatabase}=require("../database/db");

const dashboard=require("../services/dashboard");

router.get("/",async(req,res)=>{

const db=await getDatabase();

const stats=
dashboard.statistics(db);

res.render("dashboard",{

stats

});

});

module.exports=router;

EOF

############################################################
# Dashboard View
############################################################

cat > views/dashboard.ejs <<'EOF'

<%- include("partials/head") %>

<body>

<%- include("partials/sidebar") %>

<div class="content">

<h1>IDMC Research Intelligence Dashboard</h1>

<div class="cards">

<div class="card">
<h3>Projects</h3>
<h1><%= stats.projects %></h1>
</div>

<div class="card">
<h3>Publications</h3>
<h1><%= stats.publications %></h1>
</div>

<div class="card">
<h3>Researchers</h3>
<h1><%= stats.researchers %></h1>
</div>

<div class="card">
<h3>Diseases</h3>
<h1><%= stats.diseases %></h1>
</div>

<div class="card">
<h3>Datasets</h3>
<h1><%= stats.datasets %></h1>
</div>

<div class="card">
<h3>Courses</h3>
<h1><%= stats.courses %></h1>
</div>

</div>

<div class="panel">

<h2>Latest Project</h2>

<p><%= stats.latestProject %></p>

</div>

<div class="panel">

<h2>Latest Publication</h2>

<p><%= stats.latestPublication %></p>

</div>

<div class="panel">

<h2>Latest Researcher</h2>

<p><%= stats.latestResearcher %></p>

</div>

</div>

</body>

EOF

############################################################

echo ""
echo "Dashboard upgraded."

echo ""
echo "========== END OF PART 3 =========="

############################################################
#
# IDMC VERSION 14
#
# PART 4
#
# Researcher Module
#
############################################################

echo ""
echo "=============================================="
echo " PART 4"
echo " Researcher Module"
echo "=============================================="

############################################################
# Researcher Controller
############################################################

cat > controllers/ResearcherController.js <<'EOF'

const {getDatabase}=require("../database/db");
const {saveDatabase}=require("../database/db");

exports.list=async function(req,res){

const db=await getDatabase();

let researchers=[];

try{

const r=db.exec(
"SELECT id,fullname,institution,speciality,country FROM researchers ORDER BY fullname"
);

if(r.length){

researchers=r[0].values;

}

}catch(e){}

res.render("researchers/index",{

researchers

});

};

exports.addForm=function(req,res){

res.render("researchers/add");

};

exports.add=async function(req,res){

const db=await getDatabase();

const {

fullname,

institution,

department,

email,

phone,

orcid,

speciality,

country,

biography

}=req.body;

db.run(

`INSERT INTO researchers
(fullname,institution,department,email,phone,orcid,speciality,country,biography,created_at)
VALUES(?,?,?,?,?,?,?,?,?,datetime('now'))`,

[
fullname,
institution,
department,
email,
phone,
orcid,
speciality,
country,
biography
]

);

saveDatabase(db);

res.redirect("/researchers");

};

EOF

############################################################
# Researcher Routes
############################################################

cat > routes/researchers.js <<'EOF'

const express=require("express");

const router=express.Router();

const controller=require("../controllers/ResearcherController");

router.get("/",controller.list);

router.get("/add",controller.addForm);

router.post("/add",controller.add);

module.exports=router;

EOF

############################################################
# Researcher List View
############################################################

mkdir -p views/researchers

cat > views/researchers/index.ejs <<'EOF'

<%- include("../partials/head") %>

<h1>Researchers</h1>

<p>

<a href="/researchers/add">

Add Researcher

</a>

</p>

<table border="1" cellpadding="8">

<tr>

<th>Name</th>

<th>Institution</th>

<th>Speciality</th>

<th>Country</th>

</tr>

<% researchers.forEach(function(r){ %>

<tr>

<td><%= r[1] %></td>

<td><%= r[2] %></td>

<td><%= r[3] %></td>

<td><%= r[4] %></td>

</tr>

<% }) %>

</table>

EOF

############################################################
# Add Researcher View
############################################################

cat > views/researchers/add.ejs <<'EOF'

<%- include("../partials/head") %>

<h1>Add Researcher</h1>

<form method="POST" action="/researchers/add">

<p>

<input
type="text"
name="fullname"
placeholder="Full Name"
required>

</p>

<p>

<input
type="text"
name="institution"
placeholder="Institution">

</p>

<p>

<input
type="text"
name="department"
placeholder="Department">

</p>

<p>

<input
type="email"
name="email"
placeholder="Email">

</p>

<p>

<input
type="text"
name="phone"
placeholder="Phone">

</p>

<p>

<input
type="text"
name="orcid"
placeholder="ORCID">

</p>

<p>

<input
type="text"
name="speciality"
placeholder="Speciality">

</p>

<p>

<input
type="text"
name="country"
placeholder="Country">

</p>

<p>

<textarea
name="biography"
rows="6"
cols="60"
placeholder="Biography"></textarea>

</p>

<p>

<button type="submit">

Save Researcher

</button>

</p>

</form>

EOF

############################################################

echo ""
echo "Researcher module installed."

echo ""
echo "Add to server.js:"

echo 'const researcherRoutes = require("./routes/researchers");'

echo 'app.use("/researchers", researcherRoutes);'

echo ""

echo "========== END OF PART 4 =========="

############################################################
#
# IDMC VERSION 14
#
# PART 5
#
# File Upload Manager
#
############################################################

echo ""
echo "=============================================="
echo " PART 5"
echo " File Upload Manager"
echo "=============================================="

############################################################
# Install Multer
############################################################

echo ""
echo "Installing multer..."

npm install multer

############################################################
# Upload Middleware
############################################################

cat > middleware/upload/upload.js <<'EOF'

const multer=require("multer");

const path=require("path");

const storage=multer.diskStorage({

destination:function(req,file,cb){

cb(null,"uploads/documents");

},

filename:function(req,file,cb){

const filename=

Date.now()+"_"+file.originalname;

cb(null,filename);

}

});

module.exports=

multer({

storage:storage,

limits:{

fileSize:20*1024*1024

}

});

EOF

############################################################
# Upload Controller
############################################################

cat > controllers/UploadController.js <<'EOF'

exports.form=function(req,res){

res.render("uploads/index");

};

exports.upload=function(req,res){

res.render("uploads/success",{

file:req.file

});

};

EOF

############################################################
# Upload Route
############################################################

cat > routes/uploads.js <<'EOF'

const express=require("express");

const router=express.Router();

const upload=

require("../middleware/upload/upload");

const controller=

require("../controllers/UploadController");

router.get("/",

controller.form);

router.post("/",

upload.single("document"),

controller.upload);

module.exports=router;

EOF

############################################################
# Views
############################################################

mkdir -p views/uploads

cat > views/uploads/index.ejs <<'EOF'

<%- include("../partials/head") %>

<h1>Upload Document</h1>

<form

method="POST"

action="/uploads"

enctype="multipart/form-data">

<p>

<input

type="file"

name="document"

required>

</p>

<p>

<button type="submit">

Upload

</button>

</p>

</form>

EOF

cat > views/uploads/success.ejs <<'EOF'

<%- include("../partials/head") %>

<h1>Upload Successful</h1>

<p>

<b>Filename:</b>

<%= file.filename %>

</p>

<p>

<b>Original:</b>

<%= file.originalname %>

</p>

<p>

<a href="/dashboard">

Return Dashboard

</a>

</p>

EOF

############################################################

echo ""
echo "Upload manager installed."

echo ""
echo "Add to server.js"

echo ""

echo 'const uploadRoutes=require("./routes/uploads");'

echo ""

echo 'app.use("/uploads",uploadRoutes);'

echo ""

echo "========== END OF PART 5 =========="

############################################################
#
# IDMC VERSION 14
#
# PART 6
#
# Search Module
#
############################################################

echo ""
echo "=============================================="
echo " PART 6"
echo " Global Search Module"
echo "=============================================="

############################################################
# Search Controller
############################################################

cat > controllers/SearchController.js <<'EOF'

const {getDatabase}=require("../database/db");

exports.search=async function(req,res){

const db=await getDatabase();

const keyword=(req.query.q||"").trim();

let projects=[];
let publications=[];
let researchers=[];

if(keyword.length){

try{

let r=db.exec(

"SELECT id,title,year FROM projects WHERE title LIKE ?",

["%"+keyword+"%"]

);

if(r.length) projects=r[0].values;

}catch(e){}

try{

let r=db.exec(

"SELECT id,title FROM publications WHERE title LIKE ?",

["%"+keyword+"%"]

);

if(r.length) publications=r[0].values;

}catch(e){}

try{

let r=db.exec(

"SELECT id,fullname FROM researchers WHERE fullname LIKE ?",

["%"+keyword+"%"]

);

if(r.length) researchers=r[0].values;

}catch(e){}

}

res.render("search/index",{

keyword,

projects,

publications,

researchers

});

};

EOF

############################################################
# Search Route
############################################################

cat > routes/search.js <<'EOF'

const express=require("express");

const router=express.Router();

const controller=

require("../controllers/SearchController");

router.get("/",controller.search);

module.exports=router;

EOF

############################################################
# Search View
############################################################

mkdir -p views/search

cat > views/search/index.ejs <<'EOF'

<%- include("../partials/head") %>

<h1>Global Search</h1>

<form method="GET" action="/search">

<input
type="text"
name="q"
value="<%= keyword %>"
placeholder="Search">

<button type="submit">

Search

</button>

</form>

<h2>Projects</h2>

<ul>

<% projects.forEach(function(p){ %>

<li>

<%= p[1] %>

</li>

<% }) %>

</ul>

<h2>Publications</h2>

<ul>

<% publications.forEach(function(p){ %>

<li>

<%= p[1] %>

</li>

<% }) %>

</ul>

<h2>Researchers</h2>

<ul>

<% researchers.forEach(function(r){ %>

<li>

<%= r[1] %>

</li>

<% }) %>

</ul>

EOF

############################################################
# Navigation Partial
############################################################

if [ -f views/partials/sidebar.ejs ]; then

grep -q "/search" views/partials/sidebar.ejs

if [ $? -ne 0 ]; then

sed -i '/Administration/a\
<li><a href="/search">Search</a></li>' \
views/partials/sidebar.ejs

fi

fi

############################################################

echo ""
echo "Search module installed."

echo ""
echo "Add to server.js"

echo ""

echo 'const searchRoutes=require("./routes/search");'

echo ""

echo 'app.use("/search",searchRoutes);'

echo ""

echo "========== END OF PART 6 =========="

############################################################
#
# IDMC VERSION 14
#
# PART 7
#
# Dashboard Charts & Activity
#
############################################################

echo ""
echo "=============================================="
echo " PART 7"
echo " Dashboard Charts"
echo "=============================================="

############################################################
# Chart JavaScript
############################################################

mkdir -p public/js

cat > public/js/dashboard.js <<'EOF'

document.addEventListener("DOMContentLoaded",function(){

if(typeof Chart==="undefined"){

console.log("Chart.js not loaded");

return;

}

const ctx=document.getElementById("summaryChart");

if(!ctx)return;

new Chart(ctx,{

type:"bar",

data:{

labels:[
"Projects",
"Publications",
"Researchers",
"Diseases"
],

datasets:[{

label:"IDMC Summary",

data:[
window.dashboardStats.projects,
window.dashboardStats.publications,
window.dashboardStats.researchers,
window.dashboardStats.diseases
]

}]

},

options:{

responsive:true,

maintainAspectRatio:false

}

});

});

EOF

############################################################
# Dashboard View
############################################################

cat > views/dashboard.ejs <<'EOF'

<%- include("partials/head") %>

<div class="container">

<%- include("partials/sidebar") %>

<div class="content">

<h1>IDMC Research Intelligence Dashboard</h1>

<div class="cards">

<div class="card">
<h3>Projects</h3>
<h1><%= stats.projects %></h1>
</div>

<div class="card">
<h3>Publications</h3>
<h1><%= stats.publications %></h1>
</div>

<div class="card">
<h3>Researchers</h3>
<h1><%= stats.researchers %></h1>
</div>

<div class="card">
<h3>Diseases</h3>
<h1><%= stats.diseases %></h1>
</div>

</div>

<div style="height:350px">

<canvas id="summaryChart"></canvas>

</div>

<br>

<div class="panel">

<h2>Recent Activity</h2>

<ul>

<li>Latest Project:
<b><%= stats.latestProject %></b></li>

<li>Latest Publication:
<b><%= stats.latestPublication %></b></li>

<li>Latest Researcher:
<b><%= stats.latestResearcher %></b></li>

<li>Database Status:
Connected</li>

<li>Portal Version:
14</li>

</ul>

</div>

<script>

window.dashboardStats={

projects:<%= stats.projects %>,

publications:<%= stats.publications %>,

researchers:<%= stats.researchers %>,

diseases:<%= stats.diseases %>

};

</script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script src="/js/dashboard.js"></script>

</div>

EOF

############################################################
# Dashboard CSS
############################################################

cat >> public/css/dashboard.css <<'EOF'

.panel{

background:#fff;

padding:20px;

margin-top:20px;

border-radius:8px;

box-shadow:0 2px 6px rgba(0,0,0,.15);

}

canvas{

background:white;

border-radius:8px;

padding:15px;

}

EOF

############################################################

echo ""
echo "Dashboard charts installed."

echo ""
echo "========== END OF"


############################################################
#
# IDMC VERSION 14
#

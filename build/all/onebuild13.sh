#!/data/data/com.termux/files/usr/bin/bash

########################################################
#
# IDMC Version 13 Builder
#
# Research Intelligence Dashboard
#
########################################################

clear

echo "==============================================="
echo " IDMC VERSION 13"
echo " Research Intelligence Dashboard"
echo "==============================================="
echo ""

########################################################
# Directories
########################################################

echo "Creating directory structure..."

mkdir -p controllers
mkdir -p middleware
mkdir -p models
mkdir -p routes
mkdir -p services

mkdir -p uploads/projects
mkdir -p uploads/publications
mkdir -p uploads/datasets
mkdir -p uploads/images
mkdir -p uploads/documents

mkdir -p public/css
mkdir -p public/js

mkdir -p views
mkdir -p views/partials

########################################################
# Dashboard Controller
########################################################

if [ ! -f controllers/DashboardController.js ]; then

cat > controllers/DashboardController.js <<'EOF'

exports.index = async (req,res)=>{

res.render("dashboard",{

title:"IDMC Dashboard"

});

};

EOF

fi

########################################################
# Dashboard Service
########################################################

if [ ! -f services/dashboard.js ]; then

cat > services/dashboard.js <<'EOF'

exports.statistics=function(database){

let projects=0;
let publications=0;
let researchers=0;

try{

let p=database.exec(
"SELECT COUNT(*) FROM projects"
);

if(p.length)
projects=p[0].values[0][0];

}catch(e){}

try{

let q=database.exec(
"SELECT COUNT(*) FROM publications"
);

if(q.length)
publications=q[0].values[0][0];

}catch(e){}

try{

let r=database.exec(
"SELECT COUNT(*) FROM users"
);

if(r.length)
researchers=r[0].values[0][0];

}catch(e){}

return{

projects,

publications,

researchers,

diseases:8,

training:"Ready"

};

}

EOF

fi

########################################################
# Dashboard Route
########################################################

if [ ! -f routes/dashboard.js ]; then

cat > routes/dashboard.js <<'EOF'

const express=require("express");

const router=express.Router();

const {

getDatabase

}=require("../database/db");

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

fi

########################################################
# Sidebar Partial
########################################################

cat > views/partials/sidebar.ejs <<'EOF'

<div class="sidebar">

<h2>IDMC</h2>

<ul>

<li><a href="/">Home</a></li>

<li><a href="/dashboard">Dashboard</a></li>

<li><a href="/projects">Projects</a></li>

<li><a href="/publications">Publications</a></li>

<li><a href="/diseases">Disease Library</a></li>

<li><a href="/research">Research</a></li>

<li><a href="/admin">Administration</a></li>

</ul>

</div>

EOF

echo ""
echo "==============================================="
echo " Part 1 Completed"
echo "==============================================="
echo ""

echo "Created"

echo "controllers/DashboardController.js"

echo "services/dashboard.js"

echo "routes/dashboard.js"

echo "views/partials/sidebar.ejs"

echo ""

echo "Continue with Part 2."


########################################################
# Dashboard View
########################################################

cat > views/dashboard.ejs <<'EOF'

<%- include("partials/head") %>

<div class="container">

<%- include("partials/sidebar") %>

<div class="content">

<%- include("partials/topbar") %>

<h1>Research Intelligence Dashboard</h1>

<div class="cards">

<div class="card">
<h2>Projects</h2>
<h1><%= stats.projects %></h1>
</div>

<div class="card">
<h2>Publications</h2>
<h1><%= stats.publications %></h1>
</div>

<div class="card">
<h2>Researchers</h2>
<h1><%= stats.researchers %></h1>
</div>

<div class="card">
<h2>Diseases</h2>
<h1><%= stats.diseases %></h1>
</div>

</div>

<div class="panel">

<h2>Quick Access</h2>

<ul>

<li><a href="/projects">Research Projects</a></li>

<li><a href="/publications">Publications</a></li>

<li><a href="/diseases">Disease Library</a></li>

<li><a href="/research">Research</a></li>

<li><a href="/admin">Administration</a></li>

</ul>

</div>

<div class="panel">

<h2>Platform Status</h2>

<table>

<tr>
<td>Training Centre</td>
<td><%= stats.training %></td>
</tr>

<tr>
<td>Database</td>
<td>Connected</td>
</tr>

<tr>
<td>Server</td>
<td>Online</td>
</tr>

<tr>
<td>Portal</td>
<td>Version 13</td>
</tr>

</table>

</div>

</div>

</div>

EOF

########################################################
# Top Bar
########################################################

cat > views/partials/topbar.ejs <<'EOF'

<div class="topbar">

<h2>
Infectious Disease Modelling Center
</h2>

<div>

<a href="/login">Login</a>

&nbsp; | &nbsp;

<a href="/admin">Admin</a>

</div>

</div>

EOF

########################################################
# Dashboard CSS
########################################################

cat > public/css/dashboard.css <<'EOF'

body{

margin:0;

font-family:Arial,Helvetica,sans-serif;

background:#eef3f7;

}

.container{

display:flex;

min-height:100vh;

}

.sidebar{

width:240px;

background:#0b4f6c;

color:white;

padding:20px;

}

.sidebar h2{

text-align:center;

}

.sidebar ul{

list-style:none;

padding:0;

}

.sidebar li{

padding:12px 0;

}

.sidebar a{

color:white;

text-decoration:none;

}

.content{

flex:1;

padding:30px;

}

.topbar{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:25px;

}

.cards{

display:grid;

grid-template-columns:repeat(4,1fr);

gap:20px;

margin-bottom:30px;

}

.card{

background:white;

padding:25px;

border-radius:10px;

box-shadow:0 0 10px rgba(0,0,0,.15);

text-align:center;

}

.panel{

background:white;

padding:25px;

margin-top:20px;

border-radius:10px;

box-shadow:0 0 10px rgba(0,0,0,.15);

}

table{

width:100%;

border-collapse:collapse;

}

td{

padding:10px;

border-bottom:1px solid #ddd;

}

EOF

echo ""
echo "==============================================="
echo " Part 2 Completed"
echo "==============================================="
echo ""

echo "Created"

echo "views/dashboard.ejs"

echo "views/partials/topbar.ejs"

echo "public/css/dashboard.css"

echo ""

echo "Continue with Part 3."

########################################################
#
# Version 13
# Final Instructions
#
########################################################

echo ""
echo "==============================================="
echo " Dashboard Installation"
echo "==============================================="
echo ""

echo "1) Add to server.js"
echo ""

echo 'const dashboardRoutes = require("./routes/dashboard");'

echo ""

echo "2) Register route BEFORE the 404 handler"
echo ""

echo 'app.use("/dashboard", dashboardRoutes);'

echo ""

echo "3) Optional:"
echo "   Make the dashboard your home page"

echo ""

echo "Replace"

echo 'res.render("index");'

echo "with"

echo 'res.redirect("/dashboard");'

echo ""

echo "4) Add Dashboard to navbar"

echo ""

echo '<a href="/dashboard">Dashboard</a>'

echo ""

echo "==============================================="
echo " Version 13 Successfully Generated"
echo "==============================================="
echo ""

echo "Architecture"

echo ""

echo "controllers/"
ls controllers

echo ""

echo "models/"
ls models

echo ""

echo "routes/"
ls routes

echo ""

echo "services/"
ls services

echo ""

echo "views/"
ls views

echo ""

echo "Dashboard Ready."
echo ""
echo "Restart using:"
echo ""
echo "npm start"
echo ""


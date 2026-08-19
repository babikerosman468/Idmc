#!/data/data/com.termux/files/usr/bin/bash

clear

echo "=============================================="
echo " IDMC Version 12 Builder"
echo " Professional Research Platform"
echo "=============================================="

echo ""
echo "Creating folders..."

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

mkdir -p logs

########################################################
# Controllers
########################################################

if [ ! -f controllers/ProjectController.js ]; then

cat > controllers/ProjectController.js <<'EOF'
exports.index = (req,res)=>{
    res.send("Project Controller Ready");
};
EOF

fi

if [ ! -f controllers/PublicationController.js ]; then

cat > controllers/PublicationController.js <<'EOF'
exports.index = (req,res)=>{
    res.send("Publication Controller Ready");
};
EOF

fi

########################################################
# Models
########################################################

if [ ! -f models/Project.js ]; then

cat > models/Project.js <<'EOF'
class Project{

}

module.exports = Project;
EOF

fi

if [ ! -f models/Publication.js ]; then

cat > models/Publication.js <<'EOF'
class Publication{

}

module.exports = Publication;
EOF

fi

########################################################
# Middleware
########################################################

if [ ! -f middleware/auth.js ]; then

cat > middleware/auth.js <<'EOF'
module.exports=function(req,res,next){

if(req.session && req.session.user){

return next();

}

return res.redirect("/login");

}
EOF

fi

########################################################
# Services
########################################################

if [ ! -f services/dashboard.js ]; then

cat > services/dashboard.js <<'EOF'
exports.statistics=function(database){

return{

projects:0,

publications:0,

researchers:0,

diseases:0

};

}
EOF

fi

########################################################
# Routes
########################################################

for module in \
projects \
publications \
researchers \
training \
bioinformatics \
onehealth \
dashboard
do

if [ ! -f routes/${module}.js ]; then

cat > routes/${module}.js <<EOF
const express=require("express");

const router=express.Router();

router.get("/",(req,res)=>{

res.send("${module} module ready");

});

module.exports=router;
EOF

fi

done

########################################################

echo ""
echo "=============================================="
echo " IDMC Version 12 Installed"
echo "=============================================="

echo ""

echo "Controllers"
ls controllers

echo ""

echo "Models"
ls models

echo ""

echo "Middleware"
ls middleware

echo ""

echo "Routes"
ls routes

echo ""

echo "Services"
ls services

echo ""

echo "Uploads"

find uploads -maxdepth 1 -type d

echo ""

echo "Completed Successfully."

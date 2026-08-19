#!/data/data/com.termux/files/usr/bin/bash

echo ""
echo "========================================"
echo " IDMC VERSION 14 VERIFICATION"
echo "========================================"
echo ""

PASS=0
FAIL=0

check_file () {
if [ -f "$1" ]; then
    echo "[OK]  $1"
    PASS=$((PASS+1))
else
    echo "[FAIL] $1"
    FAIL=$((FAIL+1))
fi
}

check_dir () {
if [ -d "$1" ]; then
    echo "[OK]  $1/"
    PASS=$((PASS+1))
else
    echo "[FAIL] $1/"
    FAIL=$((FAIL+1))
fi
}

echo "Directories"
echo "-----------"

check_dir controllers
check_dir database
check_dir middleware
check_dir models
check_dir public
check_dir routes
check_dir services
check_dir uploads
check_dir views

echo ""
echo "Core Files"
echo "----------"

check_file server.js
check_file package.json
check_file database/db.js
check_file database/idmc.db

echo ""
echo "Views"
echo "-----"

check_file views/dashboard.ejs
check_file views/projects.ejs
check_file views/publications.ejs
check_file views/research.ejs
check_file views/diseases.ejs
check_file views/login.ejs
check_file views/admin.ejs

echo ""
echo "Routes"
echo "------"

check_file routes/dashboard.js
check_file routes/projects.js
check_file routes/publications.js
check_file routes/researchers.js
check_file routes/search.js
check_file routes/uploads.js
check_file routes/diseases.js

echo ""
echo "Controllers"
echo "-----------"

check_file controllers/DashboardController.js
check_file controllers/ProjectController.js
check_file controllers/PublicationController.js
check_file controllers/ResearcherController.js

echo ""
echo "Static Files"
echo "------------"

check_file public/style.css
check_file public/css/dashboard.css
check_file public/js/dashboard.js
check_file public/favicon.png

echo ""
echo "========================================"
echo "Verification Complete"
echo "Passed : $PASS"
echo "Failed : $FAIL"
echo "========================================"

if [ "$FAIL" -eq 0 ]; then
    echo ""
    echo "IDMC Version 14 is READY."
else
    echo ""
    echo "Some components require attention."
fi

echo ""

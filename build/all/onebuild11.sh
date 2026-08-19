#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Building IDMC Version 11"
echo " Modular Architecture"
echo "======================================"

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

# -------------------------
# Projects Route
# -------------------------

if [ ! -f routes/projects.js ]; then

cat > routes/projects.js <<'EOF'
const express = require("express");

const router = express.Router();

router.get("/", (req, res) => {

    res.send("Projects Module Ready");

});

module.exports = router;
EOF

fi

# -------------------------
# Publications Route
# -------------------------

if [ ! -f routes/publications.js ]; then

cat > routes/publications.js <<'EOF'
const express = require("express");

const router = express.Router();

router.get("/", (req, res) => {

    res.send("Publications Module Ready");

});

module.exports = router;
EOF

fi

# -------------------------
# Diseases Route
# -------------------------

if [ ! -f routes/diseases.js ]; then

cat > routes/diseases.js <<'EOF'
const express = require("express");

const router = express.Router();

router.get("/", (req, res) => {

    res.send("Disease Library Module Ready");

});

module.exports = router;
EOF

fi

# -------------------------
# Researchers Route
# -------------------------

if [ ! -f routes/researchers.js ]; then

cat > routes/researchers.js <<'EOF'
const express = require("express");

const router = express.Router();

router.get("/", (req, res) => {

    res.send("Researchers Module Ready");

});

module.exports = router;
EOF

fi

# -------------------------
# Training Route
# -------------------------

if [ ! -f routes/training.js ]; then

cat > routes/training.js <<'EOF'
const express = require("express");

const router = express.Router();

router.get("/", (req, res) => {

    res.send("Training Module Ready");

});

module.exports = router;
EOF

fi

echo ""
echo "======================================"
echo " IDMC Version 11 Structure Created"
echo "======================================"

echo ""
echo "Folders:"
echo "controllers/"
echo "middleware/"
echo "models/"
echo "routes/"
echo "services/"
echo "uploads/"

echo ""
echo "Route Files:"
ls routes

echo ""
echo "Done."

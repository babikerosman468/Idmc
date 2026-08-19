#!/data/data/com.termux/files/usr/bin/bash

###############################################################################
# Infectious Disease Modelling Center
# OneBuild Upgrade v6
# Part 1
###############################################################################

set -e

PROJECT="$HOME/idmc"

echo "======================================================"
echo " IDMC OneBuild Upgrade v6"
echo "======================================================"

if [ ! -d "$PROJECT" ]; then
    echo "ERROR:"
    echo "IDMC project not found."
    echo "Install v2 first."
    exit 1
fi

cd "$PROJECT"

echo
echo "[1] Updating npm packages..."

npm install \
express \
dotenv \
helmet \
cors \
morgan \
bcryptjs \
jsonwebtoken \
cookie-parser \
express-session \
uuid

echo
echo "[2] Creating new directories..."

mkdir -p \
database \
data \
app/routes \
app/controllers \
app/models \
app/middleware \
app/services \
public/css \
public/js \
public/images \
views/admin \
views/diseases \
views/auth \
logs \
uploads

echo
echo "[3] Creating JSON database..."

cat > data/diseases.json <<EOF
[
]
EOF

cat > data/users.json <<EOF
[
]
EOF

cat > data/projects.json <<EOF
[
]
EOF

cat > data/publications.json <<EOF
[
]
EOF

echo
echo "[4] Creating administrator account..."

node <<'EOF'

const fs=require("fs");

const bcrypt=require("bcryptjs");

const usersFile="data/users.json";

let users=[];

if(fs.existsSync(usersFile))
{
users=JSON.parse(fs.readFileSync(usersFile));
}

if(users.length===0)
{

users.push({

id:1,

username:"admin",

password:bcrypt.hashSync("admin123",10),

role:"administrator",

name:"System Administrator"

});

fs.writeFileSync(usersFile,JSON.stringify(users,null,2));

console.log("Administrator created.");

}
else
{

console.log("Users already exist.");

}

EOF

echo
echo "[5] Creating configuration..."

cat > .env <<EOF
PORT=3000
APP_NAME=IDMC
JWT_SECRET=idmc_super_secret_key
EOF

echo
echo "[6] Backing up current server..."

cp server.js server.js.v2.backup

echo
echo "======================================================"
echo "Part 1 completed successfully."
echo "Next: Part 2 (Authentication & Routing)"
echo "======================================================"




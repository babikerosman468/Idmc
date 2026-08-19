#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Building IDMC Version 8 Partials"
echo "======================================"

mkdir -p views/partials

##############################################
# head.ejs
##############################################

if [ ! -f views/partials/head.ejs ]; then

cat > views/partials/head.ejs <<'EOF'
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>IDMC Research Portal</title>

<link rel="stylesheet" href="/style.css">

</head>

<body>
EOF

echo "Created head.ejs"

else

echo "head.ejs already exists"

fi

##############################################
# header.ejs
##############################################

if [ ! -f views/partials/header.ejs ]; then

cat > views/partials/header.ejs <<'EOF'
<header>

<h1>Infectious Disease Modelling Center</h1>

<p>Version 8</p>

</header>
EOF

echo "Created header.ejs"

else

echo "header.ejs already exists"

fi


##############################################
# navbar.ejs
##############################################

if [ ! -f views/partials/navbar.ejs ]; then

cat > views/partials/navbar.ejs <<'EOF'
<nav>

<a href="/">Home</a>

<a href="/about">About</a>

<a href="/research">Research</a>

<a href="/diseases">Disease Library</a>

<a href="/login">Login</a>

<a href="/admin">Admin</a>

</nav>
EOF

echo "Created navbar.ejs"

else

echo "navbar.ejs already exists"

fi

##############################################
# footer.ejs
##############################################

if [ ! -f views/partials/footer.ejs ]; then

cat > views/partials/footer.ejs <<'EOF'
<footer>

<p>&copy; 2026 Infectious Disease Modelling Center (IDMC)</p>

</footer>

</body>
</html>
EOF

echo "Created footer.ejs"

else

echo "footer.ejs already exists"

fi

##############################################
# Finished
##############################################

echo
echo "======================================"
echo " Partials created successfully"
echo "======================================"

ls -1 views/partials

echo
echo "Next step:"
echo "Update each page to use:"
echo
echo '  <%- include("partials/head") %>'
echo '  <%- include("partials/header") %>'
echo '  <%- include("partials/navbar") %>'
echo '  <!-- page content -->'
echo '  <%- include("partials/footer") %>'
echo
echo "IDMC Version 8 build complete."


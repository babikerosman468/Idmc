#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Building IDMC Version 7 Views"
echo "======================================"

mkdir -p views

####################################################
# about.ejs
####################################################

cat > views/about.ejs <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>About IDMC</title>
<link rel="stylesheet" href="/style.css">
</head>
<body>

<header>
<h1>About IDMC</h1>
</header>

<nav>
<a href="/">Home</a>
<a href="/research">Research</a>
<a href="/diseases">Disease Library</a>
<a href="/login">Login</a>
<a href="/admin">Admin</a>
</nav>

<main>
<h2>Infectious Disease Modelling Center</h2>

<p>
The IDMC supports research, education, One Health,
bioinformatics, artificial intelligence,
and infectious disease modelling.
</p>
</main>

<footer>
© 2026 IDMC
</footer>

</body>
</html>
EOF

####################################################
# research.ejs
####################################################

cat > views/research.ejs <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Research Portal</title>
<link rel="stylesheet" href="/style.css">
</head>
<body>

<header>
<h1>Research Portal</h1>
</header>

<nav>
<a href="/">Home</a>
<a href="/about">About</a>
<a href="/diseases">Disease Library</a>
<a href="/login">Login</a>
<a href="/admin">Admin</a>
</nav>

<main>

<ul>
<li>Mathematical Modelling</li>
<li>Epidemiology</li>
<li>Bioinformatics</li>
<li>Artificial Intelligence</li>
<li>One Health</li>
</ul>

</main>

<footer>
© 2026 IDMC
</footer>

</body>
</html>
EOF

####################################################
# diseases.ejs
####################################################

cat > views/diseases.ejs <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Disease Library</title>
<link rel="stylesheet" href="/style.css">
</head>
<body>

<header>
<h1>Disease Library</h1>
</header>

<nav>
<a href="/">Home</a>
<a href="/about">About</a>
<a href="/research">Research</a>
<a href="/login">Login</a>
<a href="/admin">Admin</a>
</nav>

<main>

<ul>
<li>COVID-19</li>
<li>Malaria</li>
<li>Dengue</li>
<li>Cholera</li>
<li>Tuberculosis</li>
<li>Influenza</li>
<li>Ebola</li>
<li>Mpox</li>
</ul>

</main>

<footer>
© 2026 IDMC
</footer>

</body>
</html>
EOF

####################################################
# login.ejs
####################################################

cat > views/login.ejs <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="/style.css">
</head>
<body>

<header>
<h1>User Login</h1>
</header>

<nav>
<a href="/">Home</a>
</nav>

<main>

<form>

<p>
<input type="text" placeholder="Username">
</p>

<p>
<input type="password" placeholder="Password">
</p>

<p>
<button type="submit">Login</button>
</p>

</form>

</main>

<footer>
© 2026 IDMC
</footer>

</body>
</html>
EOF

####################################################
# admin.ejs
####################################################

cat > views/admin.ejs <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Administrator</title>
<link rel="stylesheet" href="/style.css">
</head>
<body>

<header>
<h1>Administrator Dashboard</h1>
</header>

<nav>
<a href="/">Home</a>
</nav>

<main>

<ul>
<li>Manage Users</li>
<li>Manage Projects</li>
<li>Manage Publications</li>
<li>Manage Diseases</li>
</ul>

</main>

<footer>
© 2026 IDMC
</footer>

</body>
</html>
EOF

####################################################
# 404.ejs
####################################################

cat > views/404.ejs <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>404</title>
<link rel="stylesheet" href="/style.css">
</head>
<body>

<header>
<h1>404 - Page Not Found</h1>
</header>

<main>

<p>The page you requested does not exist.</p>

<p>
<a href="/">Return Home</a>
</p>

</main>

<footer>
© 2026 IDMC
</footer>

</body>
</html>
EOF

echo
echo "======================================"
echo " Views successfully created."
echo "======================================"

ls -1 views

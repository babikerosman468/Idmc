
#!/data/data/com.termux/files/usr/bin/bash

echo ""

echo "======================================"

echo "IDMC Verification"

echo "======================================"

echo ""

echo "Checking folders..."

for d in \
controllers \
models \
routes \
views \
services \
database \
uploads \
public
do

if [ -d "$d" ]; then
echo "[OK] $d"
else
echo "[Missing] $d"
fi

done

echo ""

echo "Checking files..."

for f in \
server.js \
package.json \
database/db.js \
views/dashboard.ejs
do

if [ -f "$f" ]; then
echo "[OK] $f"
else
echo "[Missing] $f"
fi

done

echo ""

echo "Done."


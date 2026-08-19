#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# IDMC Version 14 Developer Launcher
# ==========================================

clear

echo "=================================================="
echo "      INFECTIOUS DISEASE MODELLING CENTER"
echo "                 IDMC VERSION 14"
echo "=================================================="
echo "Date : $(date)"
echo "Project : $HOME/idmc"
echo

# Go to project
cd ~/idmc || {
    echo "[ERROR] Project directory not found."
    exit 1
}

# Verify package.json
if [ ! -f package.json ]; then
    echo "[ERROR] package.json not found."
    exit 1
fi

# Verify database
if [ -f database/idmc.db ]; then
    echo "[OK] SQLite database found."
else
    echo "[WARNING] database/idmc.db not found."
fi

# Check if server is already running
if pgrep -f "node.*server.js" >/dev/null; then
    echo
    echo "[INFO] IDMC server is already running."
else
    echo
    echo "[INFO] Starting IDMC server..."
    npm start &
    SERVER_PID=$!
    sleep 5
fi

echo
echo "[INFO] Opening browser..."
termux-open-url "http://localhost:3000"

echo
echo "=================================================="
echo "IDMC Version 14 is ONLINE"
echo "URL : http://localhost:3000"
echo "=================================================="
echo
echo "Press Ctrl+C to stop monitoring."

# Keep launcher alive while server runs
if [ -n "$SERVER_PID" ]; then
    wait $SERVER_PID
else
    tail -f /dev/null
fi


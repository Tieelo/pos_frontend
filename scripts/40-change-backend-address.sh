#!/bin/bash

# Prüfen, ob die BACKEND_URL-Umgebungsvariable gesetzt ist
if [ -n "${BACKEND_URL}" ]; then
    # Pfad zur JavaScript-Datei
    file_path=$(ls /usr/share/nginx/html/assets/index-*.js)

    # Neue URL, die Sie setzen möchten
    BACKEND_URL=${BACKEND_URL}

    # Suchen und Ersetzen der URL in der Datei
    sed -i "s|{BaseURL:\"http://pos_backend:8080\"}|{BaseURL:\"$BACKEND_URL\"}|" "$file_path"
fi

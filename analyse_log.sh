#!/bin/bash

# Analyseur de logs du keylogger
# Permet d'analyser et de visualiser les logs capturés

function banner() {
    echo "==========================================="
    echo "  Analyseur de Logs - Keylogger Shell"
    echo "  Version 1.0"
    echo "==========================================="
    echo ""
}

function usage() {
    banner
    echo "Usage: $0 <fichier_log>"
    echo ""
    echo "Options d'analyse:"
    echo "  1. Afficher tout le contenu"
    echo "  2. Rechercher des mots-clés"
    echo "  3. Statistiques de frappe"
    echo "  4. Timeline des événements"
    echo "  5. Détecter les commandes sensibles"
    echo ""
    exit 1
}

function display_all() {
    local log_file="$1"
    echo "[Contenu complet du log]"
    echo "========================"
    cat "$log_file"
    echo ""
}

function search_keyword() {
    local log_file="$1"
    echo -n "Entrez le mot-clé à rechercher: "
    read keyword
    echo ""
    echo "[Résultats pour: $keyword]"
    echo "============================="
    grep -i "$keyword" "$log_file" | nl
    echo ""
}

function statistics() {
    local log_file="$1"
    echo "[Statistiques de frappe]"
    echo "========================"
    
    total_keys=$(grep -v "^\[" "$log_file" | wc -l)
    enter_count=$(grep -c "<ENTER>" "$log_file")
    backspace_count=$(grep -c "<BACKSPACE>" "$log_file")
    tab_count=$(grep -c "<TAB>" "$log_file")
    esc_count=$(grep -c "<ESC>" "$log_file")
    
    echo "Total de touches: $total_keys"
    echo "Touches ENTER: $enter_count"
    echo "Touches BACKSPACE: $backspace_count"
    echo "Touches TAB: $tab_count"
    echo "Touches ESC: $esc_count"
    echo ""
}

function timeline() {
    local log_file="$1"
    echo "[Timeline des événements]"
    echo "==========================="
    
    awk -F'[][]' '{if ($2) print $2}' "$log_file" | sort -u
    echo ""
}

function detect_sensitive() {
    local log_file="$1"
    echo "[Détection de commandes sensibles]"
    echo "===================================="
    
    sensitive_words=("password" "passwd" "sudo" "root" "ssh" "admin" "secret")
    
    for word in "${sensitive_words[@]}"; do
        count=$(grep -ic "$word" "$log_file")
        if [ $count -gt 0 ]; then
            echo "[ALERTE] Mot sensible '$word' détecté $count fois"
        fi
    done
    echo ""
}

function interactive_menu() {
    local log_file="$1"
    
    while true; do
        echo "[Menu d'analyse]"
        echo "================"
        echo "1. Afficher tout le contenu"
        echo "2. Rechercher des mots-clés"
        echo "3. Statistiques de frappe"
        echo "4. Timeline des événements"
        echo "5. Détecter les commandes sensibles"
        echo "6. Quitter"
        echo ""
        echo -n "Votre choix: "
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
                echo "Au revoir!"
                exit 0
                ;;
            *)
                echo "[ERREUR] Option invalide"
                echo ""
                ;;
        esac
        
        echo -n "Appuyez sur Entrée pour continuer..."
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
    echo "[ERREUR] Fichier introuvable: $LOG_FILE"
    exit 1
fi

clear
banner
interactive_menu "$LOG_FILE"

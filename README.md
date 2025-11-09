# shell-keylogger

Outil pédagogique de capture de frappes clavier en shell pour comprendre les risques de sécurité.

## ⚠️ AVERTISSEMENT LÉGAL

**Ce projet est strictement à des fins éducatives et de sensibilisation à la sécurité informatique.**

- ❌ **L'utilisation de ce logiciel sur des systèmes dont vous n'êtes pas propriétaire est illégale**
- ❌ **L'utilisation sans consentement explicite est interdite par la loi**
- ✅ **Utilisez uniquement dans un environnement de test contrôlé**
- ✅ **Respectez toujours la vie privée et les lois en vigueur**

L'auteur décline toute responsabilité en cas d'usage inapproprié de cet outil.

## Description

Ce projet propose deux scripts shell permettant de comprendre comment fonctionnent les keyloggers basiques et comment ils peuvent compromettre la sécurité d'un système :

- **keylogger.sh** : Script de capture des frappes clavier dans un terminal
- **analyse_log.sh** : Script d'analyse et de visualisation des logs capturés

## Fonctionnalités

### keylogger.sh

- Capture des touches en temps réel dans le terminal actuel
- Enregistrement horodaté de chaque frappe
- Détection des touches spéciales (ENTER, BACKSPACE, TAB, ESC)
- Gestion de l'arrêt propre via Ctrl+C
- Sauvegarde automatique dans un fichier log

### analyse_log.sh

- Affichage complet du contenu des logs
- Recherche de mots-clés dans les logs
- Statistiques de frappe (nombre de touches, ENTER, BACKSPACE, etc.)
- Timeline des événements
- Détection automatique de commandes sensibles
- Interface interactive en ligne de commande

## Installation

```bash
# Cloner le dépôt
git clone https://github.com/ryantsou/shell-keylogger.git
cd shell-keylogger

# Rendre les scripts exécutables
chmod +x keylogger.sh analyse_log.sh
```

## Utilisation

### Démarrer le keylogger

```bash
# Afficher l'aide
./keylogger.sh --help

# Lancer le keylogger
./keylogger.sh
```

Le script va capturer les frappes et les enregistrer dans `~/.keylog_YYYYMMDD_HHMMSS.txt`

Appuyez sur **Ctrl+C** pour arrêter la capture.

### Analyser les logs

```bash
# Lancer l'analyseur
./analyse_log.sh ~/.keylog_20231109_120000.txt
```

Vous aurez accès à un menu interactif avec plusieurs options d'analyse.

## Objectifs pédagogiques

Ce projet permet de :

1. **Comprendre les risques** : Voir concrètement comment un keylogger peut capturer des informations sensibles
2. **Sensibiliser à la sécurité** : Prendre conscience de l'importance de protéger ses systèmes
3. **Apprendre le scripting shell** : Étudier des techniques de programmation Bash
4. **Développer des compétences** : Comprendre comment détecter et se protéger contre ce type d'attaque

## Se protéger contre les keyloggers

### Bonnes pratiques

- Vérifier régulièrement les processus en cours (`ps aux`, `top`)
- Surveiller les fichiers suspects dans le système
- Utiliser un antivirus à jour
- Ne jamais exécuter de scripts inconnus
- Vérifier les permissions des fichiers sensibles
- Utiliser des gestionnaires de mots de passe

### Détection

```bash
# Rechercher les processus suspects
ps aux | grep -i keylog

# Vérifier les fichiers de log inhabituels
find ~ -name "*.keylog*" -o -name "*keylog*.txt"

# Surveiller les modifications récentes
find ~ -type f -mtime -1 -name "*.txt"
```

## Structure du projet

```
shell-keylogger/
├── keylogger.sh          # Script de capture
├── analyse_log.sh        # Script d'analyse
├── README.md             # Documentation
└── LICENSE               # Licence MIT
```

## Limitations

Ce keylogger est **volontairement limité** à des fins pédagogiques :

- Fonctionne uniquement dans le terminal où il est lancé
- Ne capture pas les frappes système globales
- Facilement détectable par l'utilisateur
- Fichiers de log visibles et non chiffrés

## Licence

Ce projet est distribué sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## Contribution

Les contributions sont les bienvenues pour améliorer l'aspect pédagogique du projet :

- Amélioration de la documentation
- Ajout de fonctionnalités d'analyse
- Correction de bugs
- Ajout de conseils de sécurité

## Ressources

- [OWASP - Application Security](https://owasp.org/)
- [ANSSI - Guide d'hygiène informatique](https://www.ssi.gouv.fr/)
- [Bash Scripting Guide](https://tldp.org/LDP/abs/html/)

## Contact

Pour toute question concernant ce projet éducatif, veuillez ouvrir une issue sur GitHub.

---

**Rappel** : Ce projet est uniquement à but éducatif. Utilisez-le de manière responsable et éthique.

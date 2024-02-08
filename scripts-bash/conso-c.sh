#!/bin/bash

# Chemin vers le fichier source C
SCRIPT_C="../c/sort/bubble-sort.c"
# Compiler le fichier C en exécutable
# Le nom de l'exécutable sera `program`
gcc $SCRIPT_C -o exec -lm

# Démarrer powerstat en arrière-plan pour mesurer la consommation énergétique
# Mesure toutes les 1 seconde pendant 60 secondes
sudo powerstat -d 0 1 480 > powerstat_output.txt &

# Exécuter le fichier C compilé
./exec

# Attendre un peu après la fin de l'exécution pour permettre à powerstat de capturer les dernières mesures
sleep 5

# Terminer powerstat
sudo pkill powerstat

# Afficher les résultats
echo "Résultats de consommation énergétique (en Watts) :"
cat powerstat_output.txt

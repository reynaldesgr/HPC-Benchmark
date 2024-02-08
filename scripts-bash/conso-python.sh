#!/bin/bash

# Chemin vers le script Python
  SCRIPT_PYTHON="../python/binary-trees/binary-trees.py"
# SCRIPT_PYTHON="../python/sort/bubble-sort.py"

# Démarrer powerstat en arrière-plan pour mesurer la consommation énergétique
# Mesure toutes les 1 seconde pendant 60 secondes
sudo powerstat -d 0 1 480 > powerstat_output.txt &

# Exécuter le script Python
python3 $SCRIPT_PYTHON

# Terminer powerstat
sudo pkill powerstat

# Afficher les résultats
echo "Résultats de consommation énergétique (en Watts) :"
cat powerstat_output.txt

#!/bin/bash

# Vérification de la présence du script à mesurer
if [ $# -ne 1 ]; then
    echo "Usage: $0 <script_to_measure.sh>"
    exit 1
fi

script_to_measure="$1"

# Vérification de l'existence du script à mesurer
if [ ! -f "$script_to_measure" ]; then
    echo "Le fichier $script_to_measure n'existe pas."
    exit 1
fi

# Exécution du script à mesurer avec perf stat pour mesurer la consommation énergétique
perf stat -e power/energy-cores/ -e power/energy-pkg/ ./"$script_to_measure"
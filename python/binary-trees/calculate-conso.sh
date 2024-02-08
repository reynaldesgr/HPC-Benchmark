#!/bin/bash

# Python
SCRIPT_PYTHON="binary-trees.py"

# Supposition de la puissance moyenne du CPU en Watts (W)
CPU_POWER_WATTS=45

# Capture le temps avant l'exécution
START=$(awk '{print $1}' /proc/uptime)

echo "$START"
# Exécute le script Python
python3 $SCRIPT_PYTHON


# Capture le temps après l'exécution
END=$(awk '{print $1}' /proc/uptime)
echo "$END"

# Calcule la différence de temps en secondes
DURATION=$(echo "$END - $START" | bc)

# Estimation de la consommation énergétique en joules
ENERGY_CONSUMPTION_J=$(echo "$CPU_POWER_WATTS * $DURATION" | bc)

echo "Durée d'exécution: $DURATION secondes"
echo "Consommation énergétique estimée: $ENERGY_CONSUMPTION_J Joules"

#!/bin/bash

SCRIPT="bubble-sort.py"

python3 $SCRIPT &
PID=$!

sleep 2

top -b -d 2 -n 10 -p $PID > usage_$PID.txt

wait $PID

echo "Terminated."

echo "Analyse de l'utilisation du CPU et de la mémoire..."
CPU_USAGE=$(grep "python" usage_$PID.txt | awk '{print $9}' | awk '{sum+=$1} END {print sum/NR}')
MEM_USAGE=$(grep "python" usage_$PID.txt | awk '{print $10}' | awk '{sum+=$1} END {print sum/NR}')

echo "Utilisation moyenne du CPU : $CPU_USAGE%"
echo "Utilisation moyenne de la mémoire : $MEM_USAGE%"

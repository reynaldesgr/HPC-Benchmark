#!/bin/bash

path="./"


cd "${base_path}python/sort"
echo "[Bubble sort] - run Python file..."
time python3 bubble-sort.py
cd - > /dev/null
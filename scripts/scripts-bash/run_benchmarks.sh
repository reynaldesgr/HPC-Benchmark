#!/bin/bash

base_path="../../"


# BENCHMARKS

#cd "${base_path}c/fasta"
#gcc fasta.c -o fasta
#echo "[Fasta] - run C file..."
#time ./fasta 25000000
#cd - > /dev/null

################################################


#cd "${base_path}python/fasta"
#echo "[Fasta] - run Python file..."
#time python3 fasta.py
#cd - > /dev/null

#################################################

cd "${base_path}rust/fannkuch-redux"
rustc fannkuch-redux.rs -o fannkuch-redux
echo "[Fannkuch redux] - run Rust file..."
time ./fannkuch-redux
cd - > /dev/null

#################################################


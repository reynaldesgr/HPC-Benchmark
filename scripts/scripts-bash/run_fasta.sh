#!/bin/bash

base_path="../../"

# FASTA

#cd "${base_path}c/fasta"
#gcc fasta.c -o fasta
#echo "[Fasta] - run C file..."
#time ./fasta 25000000
#cd - > /dev/null

################################################

#cd "${base_path}erlang/fasta"
#erlc fasta.erl
#echo "[Fasta] - run Erlang file..."
#time erl -noshell -run fasta main 25000000
#cd - > /dev/null
#echo -e "\n\n"

################################################

#cd "${base_path}python/fasta"
#echo "[Fasta] - run Python file..."
#time python3 fasta.py 25000000
#cd - > /dev/null

#################################################

cd "${base_path}rust/fasta"
rustc fasta.rs -o fasta
echo "[Fasta] - run Rust file..."
time ./fasta 25000000
cd - > /dev/null

#################################################


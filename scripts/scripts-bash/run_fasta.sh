#!/bin/bash

base_path="../../"

# FASTA

cd "${base_path}C/fasta"
gcc fasta.c -o fasta
echo "[Fasta] - run C file..."
time ./fasta 25000000
cd - > /dev/null

################################################

cd "${base_path}Erlang/fasta"
erlc fasta.erl
echo "[Binary trees] - run Erlang file..."
time erl -noshell -s fasta main 25000000 -s init stop
cd - > /dev/null
echo -e "\n\n"

################################################


cd "${base_path}Python/fasta"
echo "[Fasta] - run Python file..."
time python3 fasta.py 25000000
cd - > /dev/null

#################################################

cd "${base_path}Rust/fannkuch-redux"
rustc fannkuch-redux.rs -o fannkuch-redux
echo "[Fasta] - run Rust file..."
time ./fasta 25000000
cd - > /dev/null

#################################################


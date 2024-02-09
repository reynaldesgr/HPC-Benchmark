#!/bin/bash

base_path="../../"


# BENCHMARKS

#cd "${base_path}c/fasta"
#gcc fasta.c -o fasta
#echo "[Fasta] - run C file..."
#time ./fasta
#cd - > /dev/null

################################################


#cd "${base_path}python/fasta"
#echo "[Fasta] - run Python file..."
#time python3 fasta.py
#cd - > /dev/null

cd "${base_path}python/fannkuch-redux"
echo "[Fannkuch redux] - run Python file..."
time python3 fannkuch-redux.py
cd - > /dev/null

#################################################

cd "${base_path}rust/fannkuch-redux"
rustc fannkuch-redux.rs -o fannkuch-redux
echo "[Fannkuch redux] - run Rust file..."
time ./fannkuch-redux
cd - > /dev/null

#################################################

cd "${base_path}erlang/fannkuch-redux"
erlc fannkuch.erl
echo "[Fannkuch redux] - run Erlang file..."
time erl -noshell -s fannkuch main -s init stop
cd - > /dev/null

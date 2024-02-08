#!/bin/bash

base_path="./"


# BENCHMARKS

cd "${base_path}c/binary-trees"
gcc binary-trees.c -o binary-trees
echo "[Binary trees] - run C file..."
time ./binary-trees
cd - > /dev/null

cd "${base_path}c/fasta"
gcc fasta.c -o fasta
echo "[Fasta] - run C file..."
time ./fasta
cd - > /dev/null


cd "${base_path}c/fannkuch-redux"
gcc fannkuch-redux.c -o fannkuch-redux
echo "[Fannkuch redux] - run C file..."
time ./fannkuch-redux
cd - > /dev/null

################################################

cd "${base_path}python/binary-trees"
echo "[Binary trees] - run Python file..."
time python3 binary-trees.py
cd - > /dev/null

cd "${base_path}python/fasta"
echo "[Fasta] - run Python file..."
time python3 fasta.py
cd - > /dev/null

cd "${base_path}python/fannkuch-redux"
echo "[Fannkuch redux] - run Python file..."
time python3 binary-trees.py
cd - > /dev/null

#################################################

cd "${base_path}rust/binary-trees"
rustc binary-trees.rs -o binary-trees
echo "[Binary trees] - run Rust file..."
time ./binary-trees
cd - > /dev/null

cd "${base_path}rust/fasta"
rustc fasta.rs -o fasta
echo "[Fasta] - run Rust file..."
time ./binary-trees
cd - > /dev/null

cd "${base_path}rust/fannkuch-redux"
rustc fannkuch-redux.rs -o fannkuch-redux
echo "[Fannkuch redux] - run Rust file..."
time ./fannkuch-redux
cd - > /dev/null

#################################################


cd "${base_path}erlang/rbinary-trees"
erlc binary_trees.erl
echo "[Binary trees] - run Erlang file..."
time erl -noshell -s binary_trees main -s init stop
cd - > /dev/null

#!/bin/bash

base_path="../../"

# BINARY TREES

cd "${base_path}C/binary_trees"
gcc binary-trees.c -o binary-trees
echo "[Binary trees] - run C file..."
time ./binary-trees
cd - > /dev/null

################################################


cd "${base_path}Erlang/binary_trees"
erlc binary_trees.erl
echo "[Binary trees] - run Erlang file..."
time erl -noshell -s binary_trees main -s init stop
cd - > /dev/null
echo -e "\n\n"

################################################

cd "${base_path}Python/binary_trees"
echo "[Binary trees] - run Python file..."
time python3 binary-trees.py
cd - > /dev/null

#################################################

cd "${base_path}Rust/binary_trees"
rustc binary-trees.rs -o binary-trees
echo "[Binary trees] - run Rust file..."
time ./binary-trees
cd - > /dev/null

#################################################


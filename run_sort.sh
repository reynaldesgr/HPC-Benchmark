#!/bin/bash

path="./"

cd "${base_pth}c/sort"
gcc bubble-sort.c -o bubble-sort_c
echo "[Bubble sort] - run C file..."
time ./bubble-sort_c
cd - > /dev/null

cd "${base_path}python/sort"
echo "[Bubble sort] - run Python file..."
time python3 bubble-sort.py
cd - > /dev/null


cd "${base_path}rust/sort"
rustc bubble-sort.rs -o bubble-sort_rust
echo "[Bubble sort] - run Rust file..."
time ./bubble-sort_rust
cd - > /dev/null

cd "${base_path}erlang/sort"
erlc bubble_sort.erl
echo "[Bubble sort] - run Erlang file..."
time erl -noshell -s bubble_sort main -s init stop
cd - > /dev/null

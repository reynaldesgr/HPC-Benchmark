#!/bin/bash

base_path="../../"

cd "${base_pth}c/regex"
gcc pattern-search.c -o pattern-search_c
echo "[Pattern search] - run C file..."
time ./pattern-search_c
cd - > /dev/null

cd "${base_path}python/regex"
echo "[Pattern search] - run Python file..."
time python3 pattern-search.py
cd - > /dev/null

cd "${base_path}rust/regex"
rustc pattern-search.rs -o pattern-search_rust
echo "[Pattern search] - run Rust file..."
time ./pattern-search_rust
cd - > /dev/null

cd "${base_path}erlang/regex"
erlc pattern_search.erl
echo "[Pattern search] - run Erlang file..."
time erl -noshell -s pattern_search main -s init stop
cd - > /dev/null
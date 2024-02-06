#!/bin/bash

path="./"

cd "${base_pth}c/recursion"
gcc fibonacci.c -o fibo_c
echo "[Recursion] - run C file..."
time ./fibo_c
cd - > /dev/null

cd "${base_path}python/recursion"
echo "[Recursion] - run Python file..."
time python3 fibonacci.py
cd - > /dev/null

cd "${base_path}rust/recursion"
rustc fibonacci.rs -o fibo_rust
echo "[Recursion] - run Rust file..."
time ./fibo_rust
cd - > /dev/null

cd "${base_path}erlang/recursion"
erlc fibonacci.erl
echo "[Recursion] - run Erlang file..."
time erl -noshell -s fibonacci main -s init stop
cd - > /dev/null

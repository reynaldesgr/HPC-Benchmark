#!/bin/bash

base_path="../../"

cd "${base_path}c/recursion"
gcc fibonacci.c -o fibo_c
echo "[Recursion] - run C file..."
time ./fibo_c
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}cpp/recursion"
g++ fibonacci.cpp -o fibo_cpp
echo "[Recursion] - run C++ file..."
time ./fibo_cpp
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}erlang/recursion"
erlc fibonacci.erl
echo "[Recursion] - run Erlang file..."
time erl -noshell -s fibonacci main -s init stop
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}fortran/recursion"
gfortran -o fibo_fortran ./*.f90
echo "[Recursion] - run Fortran file..."
time ./fibo_fortran
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}java/recursion"
javac -d bin -sourcepath src src/Fibonacci.java
echo "[Recursion] - run Java file..."
time java -cp bin Fibonacci
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}python/recursion"
echo "[Recursion] - run Python file..."
time python3 fibonacci.py
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}ruby/recursion"
echo "[Recursion] - run Ruby file..."
time ruby fibonacci.rb
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}rust/recursion"
rustc fibonacci.rs -o fibo_rust
echo "[Recursion] - run Rust file..."
time ./fibo_rust
cd - > /dev/null
echo -e "\n\n"
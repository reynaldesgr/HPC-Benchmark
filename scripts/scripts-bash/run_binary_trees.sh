#!/bin/bash

base_path="../../"


# BINARY TREES

cd "${base_path}c/binary-trees"
gcc binary-trees.c -o binary-trees_c
echo "[Binary trees] - run C file..."
time ./binary-trees_c
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}cpp/binary-trees"
g++ binary-trees.cpp -o binary-trees_cpp
echo "[Binary trees] - run C++ file..."
time ./binary-trees_cpp
cd - > /dev/null
echo -e "\n\n"


cd "${base_path}erlang/binary-trees"
erlc binary_trees.erl
echo "[Binary trees] - run Erlang file..."
time erl -noshell -s binary_trees main -s init stop
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}fortran/binary-trees"
gfortran -o binary-trees_fortran ./*.f90
echo "[Binary trees] - run Fortran file..."
time ./binary-trees_fortran
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}java/binary-trees"
javac -d bin -sourcepath src src/BinaryTree.java
echo "[Binary trees] - run Java file..."
time java -cp bin BinaryTree
cd - > /dev/null
echo -e "\n\n"


cd "${base_path}python/binary-trees"
echo "[Binary trees] - run Python file..."
time python3 binary-trees.py
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}ruby/binary-trees"
echo "[Binary trees] - run Ruby file..."
time ruby binary-trees.rb
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}rust/binary-trees"
rustc binary-trees.rs -o binary-trees_rust
echo "[Binary trees] - run Rust file..."
time ./binary-trees_rust
cd - > /dev/null
echo -e "\n\n"
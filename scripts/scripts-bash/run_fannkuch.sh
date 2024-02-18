#!/bin/bash

base_path="../../"


# FANNKUCH

cd "${base_path}c/fannkuch-redux"
gcc fannkuchredux.c -o fannkuch-redux_c
echo "[Fannkuch redux] - run C file..."
time ./fannkuch-redux_c
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}c++/fannkuch-redux"
g++ fannkuchredux.cpp -o fannkuch-redux_cpp
echo "[Fannkuch redux] - run C++ file..."
time ./fannkuch-redux_cpp
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}erlang/fannkuch-redux"
erlc fannkuch.erl
echo "[Fannkuch redux] - run Erlang file..."
time erl -noshell -run fannkuch main 12
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}fortran/fannkuch-redux"
gfortran -o fannkuch-redux_fortran ./*.f90
echo "[Fannkuch redux] - run Fortran file..."
time ./fannkuch-redux_fortran 12
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}java/fannkuch-redux"
javac -d bin -sourcepath src src/fannkuchredux.java
echo "[Fannkuch redux] - run Java file..."
time java -cp bin fannkuchredux 12
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}python/fannkuch-redux"
echo "[Fannkuch redux] - run Python file..."
time python3 fannkuchredux.py
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}ruby/fannkuch-redux"
echo "[Fannkuch redux] - run Ruby file..."
time ruby fannkuchredux.rb 12
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}rust/fannkuch-redux"
rustc fannkuchredux.rs -o fannkuch-redux_rust
echo "[Fannkuch redux] - run Rust file..."
time ./fannkuch-redux_rust
cd - > /dev/null

# #!/bin/bash

base_path="../../"

cd "${base_path}c/sort"
gcc bubble-sort.c -o sort_c
echo "[Bubble sort] - run C file..."
time ./sort_c
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}cpp/sort"
g++ bubble-sort.cpp -o sort_cpp
echo "[Bubble sort] - run C++ file..."
time ./sort_cpp
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}erlang/sort"
erlc bubble_sort.erl
echo "[Bubble sort] - run Erlang file..."
time erl -noshell -s bubble_sort main -s init stop
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}fortran/sort"
gfortran -o bubble-sort_fortran -ffree-line-length-none -fmax-array-constructor=1000000 ./*.f90
echo "[Bubble sort] - run Fortran file..."
time ./sort_fortran
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}java/sort"
javac -d bin -sourcepath src src/BubbleSort.java
echo "[Bubble sort] - run Java file..."
time java -cp bin BubbleSort
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}python/sort"
echo "[Bubble sort] - run Python file..."
time python3 bubble-sort.py
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}ruby/sort"
echo "[Bubble sort] - run Ruby file..."
time ruby bubble-sort.rb
cd - > /dev/null
echo -e "\n\n"

cd "${base_path}rust/sort"
rustc bubble-sort.rs -o sort_rust
echo "[Bubble sort] - run Rust file..."
time ./sort_rust
cd - > /dev/null
echo -e "\n\n"
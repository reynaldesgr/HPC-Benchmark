#!/bin/bash

numbers=$(shuf -i 1-100000)

# C
output_c="c-array.txt"
echo "int array[100000] = {" > "$output_c"
echo "$numbers" | awk 'NR < 100000 { printf "%s, ", $0; next } { print $0 }' >> "$output_c"
echo "};" >> "$output_c"

# Python
output_py="python_array.txt"
echo "array = [" > "$output_py"
echo "$numbers" | awk 'NR < 100000 { printf "%s, ", $0; next } { print $0 }' >> "$output_py"
echo "]" >> "$output_py"

# Erlang
output_erl="erlang_array.txt"
echo "Array = [" > "$output_erl"
echo "$numbers" | awk 'NR < 100000 { printf "%s, ", $0; next } { print $0 }' >> "$output_erl"
echo "]." >> "$output_erl"

# Rust
output_rs="rust_array.txt"
echo "let array: [i32; 100000] = [" > "$output_rs"
echo "$numbers" | awk 'NR < 100000 { printf "%s, ", $0; next } { print $0 }' >> "$output_rs"
echo "];" >> "$output_rs"

echo "(Success) : Generated random arrays for C, Python, Erlang, and Rust."

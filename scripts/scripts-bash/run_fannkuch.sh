#!/bin/bash

base_path="../../"

# FANNKUCH

cd "${base_path}C/fannkuch_redux"
gcc fannkuch-redux.c -o fannkuch-redux
echo "[Fannkuch redux] - run C file..."
time ./fannkuch-redux
cd - > /dev/null

################################################

cd "${base_path}Erlang/fannkuch_redux"
erlc fannkuch.erl
echo "[Fannkuch redux] - run Erlang file..."
time erl -noshell -s fannkuch main -s init stop
cd - > /dev/null
echo -e "\n\n"

################################################
cd "${base_path}Python/fannkuch_redux"
echo "[Fannkuch redux] - run Python file..."
time python3 fannkuch-redux
cd - > /dev/null

#################################################

cd "${base_path}Rust/fannkuch-redux"
rustc fannkuch-redux.rs -o fannkuch-redux
echo "[Fannkuch redux] - run Rust file..."
time ./fannkuch-redux 
cd - > /dev/null

#################################################


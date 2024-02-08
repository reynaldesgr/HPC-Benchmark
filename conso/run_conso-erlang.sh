#!/bin/bash

script_to_measure="$1"

erlc ../erlang/binary-trees/binary_trees.erl
perf stat -e power/energy-cores/ -e power/energy-pkg/ erl -noshell -s binary_trees main -s init stop

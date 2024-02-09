#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <script_to_measure.py>"
    exit 1
fi

script_to_measure="$1"

if [ ! -f "$script_to_measure" ]; then
    echo "File $script_to_measure does not exists."
    exit 1
fi

perf stat -e power/energy-cores/ -e power/energy-pkg/ python3 "$script_to_measure"

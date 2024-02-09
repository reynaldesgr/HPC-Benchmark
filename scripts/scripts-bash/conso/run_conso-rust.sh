#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <script_to_measure.rs>"
    exit 1
fi

script_to_measure="$1"

if [ ! -f "$script_to_measure" ]; then
    echo "FIle does not exists."
    exit 1
fi

perf stat -e power/energy-cores/ -e power/energy-pkg/ ./"${script_to_measure%.rs}"

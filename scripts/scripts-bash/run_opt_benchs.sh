#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <source_file.c> [args for executable...]"
    exit 1
fi

SOURCE="$1"
shift  
ARGS="$@"  
BASENAME=$(basename "$SOURCE" .c)
OPTIMIZATIONS=("-O0" "-O1" "-O2" "-O3" "-Os")
OUTPUT_DIR="../../results"
OUTPUT_FILE="${OUTPUT_DIR}/${BASENAME}_compilation_stats.csv"

echo "Optimization,Real Time(s),User Time(s),System Time(s),Binary Size(bytes)" > "$OUTPUT_FILE"

for OPT in "${OPTIMIZATIONS[@]}"; do
    BIN="${BASENAME}${OPT//[-]/_}"
    echo "Compiling $SOURCE with optimization $OPT..."
    gcc $OPT "$SOURCE" -o "$BIN"

    if [ $? -eq 0 ]; then
        echo "Running $BIN with arguments $ARGS..."
        TIME_STATS=$(/usr/bin/time -p ./$BIN $ARGS 2>&1)
        REAL_TIME=$(echo "$TIME_STATS" | grep real | awk '{print $2}')
        USER_TIME=$(echo "$TIME_STATS" | grep user | awk '{print $2}')
        SYS_TIME=$(echo "$TIME_STATS" | grep sys | awk '{print $2}')
        
        BINARY_SIZE=$(stat -c %s "$BIN")
        
        echo "${OPT},${REAL_TIME},${USER_TIME},${SYS_TIME},${BINARY_SIZE}" >> "$OUTPUT_FILE"
    else
        echo "Compilation failed for optimization $OPT"
        echo "${OPT},Compilation Failed,,,," >> "$OUTPUT_FILE"
    fi

    rm "$BIN"
done

echo "Benchmark results have been saved to $OUTPUT_FILE"

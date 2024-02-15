#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <source_file.rs> [args for executable...]"
    exit 1
fi

SOURCE="$1"
shift  
ARGS="$@"  
BASENAME=$(basename "$SOURCE" .rs)
OPTIMIZATIONS=("0" "1" "2" "3" "s" "z")
OUTPUT_DIR="../../results"
OUTPUT_FILE="${OUTPUT_DIR}/${BASENAME}_compilation_stats-rust.csv"
EXECUTIONS=30

echo "Optimization,Real Time(s),User Time(s),System Time(s),Binary Size(bytes)" > "$OUTPUT_FILE"

for OPT in "${OPTIMIZATIONS[@]}"; do
    BIN="${BASENAME}_opt${OPT}"
    echo "Compiling $SOURCE with optimization level $OPT..."
    rustc -C opt-level=$OPT "$SOURCE" -o "$BIN"

    if [ $? -eq 0 ]; then
        TOTAL_REAL_TIME=0
        for i in $(seq 1 $EXECUTIONS); do
            echo "Compiling $SOURCE with optimization level $OPT..."
            rustc -C opt-level=$OPT "$SOURCE" -o "$BIN"
            echo "Running $BIN with arguments $ARGS... (Attempt $i)"
            TIME_STATS=$(/usr/bin/time -p ./$BIN $ARGS 2>&1)
            REAL_TIME=$(echo "$TIME_STATS" | grep real | awk '{print $2}')
            USER_TIME=$(echo "$TIME_STATS" | grep user | awk '{print $2}')
            SYS_TIME=$(echo "$TIME_STATS"  | grep sys  | awk '{print $2}')
            
            if [ $i -eq 1 ]; then
                BINARY_SIZE=$(stat -c %s "$BIN")
            fi
            
            TOTAL_REAL_TIME=$(echo "$TOTAL_REAL_TIME + $REAL_TIME" | bc)
            echo "${OPT},${REAL_TIME},${USER_TIME},${SYS_TIME},${BINARY_SIZE}" >> "$OUTPUT_FILE"
        done
        AVERAGE_REAL_TIME=$(echo "scale=2; $TOTAL_REAL_TIME / $EXECUTIONS" | bc)
        echo "$AVERAGE_REAL_TIME" >> "$OUTPUT_FILE"
    
    else
        echo "Compilation failed for optimization level $OPT"
        echo "${OPT} - Compilation Failed" >> "$OUTPUT_FILE"
    fi

    rm "$BIN"
done

echo "Benchmark results have been saved to $OUTPUT_FILE"
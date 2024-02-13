#!/bin/bash

# Path to the C source file
SOURCE_FILE="test.c"

# Compilation options to test
OPTIONS=("-ffast-math" "-ffloat-store" "-ffp-contract=off" "-ffp-contract=on" "-mfpmath=sse" "-mfpmath=387" "-frounding-math" "-fsignaling-nans")

# Compile and execute with each option
for OPTION in "${OPTIONS[@]}"; do
    # Executable file name based on the option
    EXECUTABLE="test$(echo $OPTION | tr -d '=-')"
    # Compile with the current option
    gcc $OPTION -o $EXECUTABLE $SOURCE_FILE
    # Execute and redirect output
    ./$EXECUTABLE > "${EXECUTABLE}_output.txt"
done

# Compare outputs and save differences
for i in ${!OPTIONS[@]}; do
    for j in $(seq $((i + 1)) ${#OPTIONS[@]}); do
        EXEC1="test$(echo ${OPTIONS[$i]} | tr -d '=-')"
        EXEC2="test$(echo ${OPTIONS[$j]} | tr -d '=-')"
        if [ -f "${EXEC1}_output.txt" ] && [ -f "${EXEC2}_output.txt" ]; then
            DIFF_FILE="diff_${EXEC1}_${EXEC2}.txt"
            diff "${EXEC1}_output.txt" "${EXEC2}_output.txt" > $DIFF_FILE
            if [ -s $DIFF_FILE ]; then
                echo "Differences found between $EXEC1 and $EXEC2 and saved in $DIFF_FILE."
            else
                echo "No difference found between $EXEC1 and $EXEC2."
                rm $DIFF_FILE
            fi
        fi
    done
done

# Clean up executables
for OPTION in "${OPTIONS[@]}"; do
    EXECUTABLE="test$(echo $OPTION | tr -d '=-')"
    rm $EXECUTABLE
done

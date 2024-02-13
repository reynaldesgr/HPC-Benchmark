#!/bin/bash

SOURCE_FILE="test.c"
OPTIONS=("-ffast-math" "-ffloat-store" "-ffp-contract=off" "-ffp-contract=on" "-mfpmath=sse" "-mfpmath=387" "-frounding-math" "-fsignaling-nans")

mkdir -p diff

for OPTION in "${OPTIONS[@]}"; do
    EXECUTABLE="$(echo $OPTION | tr -d '=-')"
    gcc $OPTION -o "diff/$EXECUTABLE" $SOURCE_FILE
    "./diff/$EXECUTABLE" > "diff/${EXECUTABLE}.txt"
done

for i in ${!OPTIONS[@]}; do
    for j in $(seq $((i + 1)) ${#OPTIONS[@]}); do
        EXEC1="$(echo ${OPTIONS[$i]} | tr -d '=-')"
        EXEC2="$(echo ${OPTIONS[$j]} | tr -d '=-')"
        if [ -f "diff/${EXEC1}.txt" ] && [ -f "diff/${EXEC2}.txt" ]; then
            DIFF_FILE="diff/diff_${EXEC1}_${EXEC2}.txt"
            diff "diff/${EXEC1}.txt" "diff/${EXEC2}.txt" > "$DIFF_FILE"
            if [ -s "$DIFF_FILE" ]; then
                echo "> differences found between $EXEC1 and $EXEC2  ($DIFF_FILE)."
            else
                echo "> no differences found between $EXEC1 and $EXEC2."
                rm "$DIFF_FILE" 
            fi
        fi
    done
done

for OPTION in "${OPTIONS[@]}"; do
    EXECUTABLE="$(echo $OPTION | tr -d '=-')"
    rm "diff/$EXECUTABLE"
done
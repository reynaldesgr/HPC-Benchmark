#!/bin/bash

baseMatrixFile="matrix.txt"
languages=("Java" "C" "C++" "Rust" "Python" "Ruby" "Erlang" "Fortran")
echo "Generation of matrix 500 x 500..."
for i in $(seq 1 10); do
    for j in $(seq 1 10); do
        printf "%.2f, " $(awk -v seed=$RANDOM 'BEGIN { srand(seed); print rand() }') >> $baseMatrixFile
    done
    printf "\n" >> $baseMatrixFile
done
echo "Generated."


translateMatrix() {
    local lang=$1
    local inputFile=$2
    local outputFile="matrix_$lang.txt"

    case $lang in
        C|C++)
            echo "double matrix[500][500] = {" > $outputFile
            awk ' { gsub(/, $/, ""); printf "{%s}\n", $0 } ' $inputFile | sed 's/ / /g' >> $outputFile
            echo "};" >> $outputFile
            ;;
        Java)
            awk '{ printf "%s\n", $0 }' $inputFile | sed 's/ / /g' >> $outputFile
            ;;
        Rust)
            echo "let matrix: [[f64; 10]; 10] = [" > $outputFile
                awk '{
                    gsub(/, $/, ""); 
                    print "["$0"],"
                }' $inputFile >> $outputFile
                echo "];" >> $outputFile
            ;;
        Python|Ruby)
            echo "matrix = [" > $outputFile
            awk '{
                gsub(/, $/, ""); 
                print "["$0"],"
            }' $inputFile >> $outputFile
            echo "] " >> $outputFile
            ;;
        *)
            ;;
    esac
}

for lang in "${languages[@]}"; do
    echo "Translation for $lang..."
    translateMatrix $lang $baseMatrixFile
done

echo "Terminated"
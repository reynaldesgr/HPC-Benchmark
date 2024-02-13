#!/bin/bash

baseMatrixFile="matrix.txt"

echo "Generation of matrix 500 x 500..."
for i in $(seq 1 500); do
    for j in $(seq 1 500); do
        printf "%.2f " $(awk -v seed=$RANDOM 'BEGIN { srand(seed); print rand() }') >> $baseMatrixFile
    done
    printf "\n" >> $baseMatrixFile
done
echo "Generated."

translateMatrix() {
    local lang=$1
    local inputFile=$2
    local outputFile="matrix_$lang.txt"

    case $lang in
        C|C++|Java)
            echo "double matrix[500][500] = {" > $outputFile
            awk '{ printf "{%s},\n", $0 }' $inputFile | sed 's/ /, /g' >> $outputFile
            echo "};" >> $outputFile
            ;;
        Rust)
            echo "let matrix: [[f64; 500]; 500] = [" > $outputFile
            awk '{ printf "[%s],\n", $0 }' $inputFile | sed 's/ /, /g' >> $outputFile
            echo "];" >> $outputFile
            ;;
        Python)
            echo "matrix = [" > $outputFile
            awk '{
                gsub(/ /, ", ", $0);
                sub(/, $/, "", $0);
                printf "[%s],\n", $0
            }' $inputFile >> $outputFile
            echo "]" >> $outputFile
            ;;
        Ruby)
            echo "matrix = [" > $outputFile
            awk '{
                gsub(/ /, ", ", $0);
                sub(/, $/, "", $0);  
                printf "[%s],\n", $0 
            }' $inputFile >> $outputFile
            echo "]" >> $outputFile
            ;;
        Erlang)
            echo "Matrix = [" > $outputFile
            awk '{
                gsub(/ /, ", ", $0);
                sub(/, $/, "", $0);  
                printf "[%s],\n", $0
            }' $inputFile >> $outputFile
            echo "]." >> $outputFile
            ;;
        Fortran)
            echo "double precision, dimension(500,500) :: matrix" > $outputFile
            echo "data matrix /" >> $outputFile
            awk '{
                gsub(/ /, ", ", $0);
                printf "%s", $0
                if (NR < 500) printf ",\n"; 
            }' $inputFile >> $outputFile
            echo "/" >> $outputFile
            ;;
        *)
            echo "Langage non pris en charge : $lang"
            ;;
    esac
}

lang="Ruby"
echo "Translation for $lang..."
translateMatrix $lang $baseMatrixFile

echo "Terminated"
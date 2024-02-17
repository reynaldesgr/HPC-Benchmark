#!/bin/bash

# Usage: ./script.sh <language> <source_path> [bin_dir] [source_dir] [args...]

LANGUAGE=$1
SOURCE_PATH=$2
BIN_DIR=$3       # Binary directory for Java compilation output
SOURCE_DIR=$4    # Source directory for Java source files
shift 4

FILE_NAME=$(basename "${SOURCE_PATH%.*}")
RESULTS_FILE="${LANGUAGE}-power_results-${FILE_NAME}.txt"

compile_and_run() {
    echo $@
    case $1 in
        c)
            gcc "$2" -o exec
            if [[ -n "$@" ]]; then
                PROGRAM="./exec $@"
            else
                PROGRAM="./exec"
            fi
            ;;
        c++)
            g++ "$2" -o exec
            if [[ -n "$@" ]]; then
                PROGRAM="./exec $@"
            else
                PROGRAM="./exec"
            fi
            ;;
        fortran)
            gfortran "$2" -o exec
            if [[ -n "$@" ]]; then
                PROGRAM="./exec $@"
            else
                PROGRAM="./exec"
            fi
            ;;
        java)
            javac -d "$BIN_DIR" -sourcepath "$SOURCE_DIR" "$2"
            class_name=$(basename "${2%.java}")
            PROGRAM="java -cp $BIN_DIR $class_name"
            ;;
        rust)
            rustc "$2" -o exec
            if [[ -n "$@" ]]; then
                PROGRAM="./exec $@"
            else
                PROGRAM="./exec"
            fi
            ;;
        erlang)
            erlc "$2"
            executable_name="${2%.*}"
            if [[ -n "$@" ]]; then
                PROGRAM="erl -noshell -run ${executable_name} main $@"
            else
                PROGRAM="erl -noshell -s ${executable_name} main -s init stop"
            fi
            ;;
        python)
            if [[ -n "$@" ]]; then 
                PROGRAM="python3 $2 $@"
            else
                PROGRAM="python3 $2"
            fi
            ;;
        ruby)
            if [[ -n "$@" ]]; then 
                PROGRAM="ruby $2 $@"
            else
                PROGRAM="ruby $2"
            fi
            ;;
        *)
            echo "Unsupported language: $1"
            exit 1
            ;;
    esac
    
    for i in {1..30}
    do
        echo "[Measure $i] - PowerJoular executing..."
        $PROGRAM &
        
        PROGRAM_PID=$!
        
        sudo powerjoular -p $PROGRAM_PID >> "$RESULTS_FILE" &
        POWERJOULAR_PID=$!

        sleep 60

        kill -INT $POWERJOULAR_PID
        echo "[Measure] - Done."
        kill -INT $PROGRAM_PID
    done
}

compile_and_run $LANGUAGE $SOURCE_PATH "$@"
if [ -f exec ]; then
    rm exec
fi

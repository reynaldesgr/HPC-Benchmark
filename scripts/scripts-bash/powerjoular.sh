#!/bin/bash

# Usage: ./script.sh <language> <source_path> [bin_dir] [source_dir] [args...]

LANGUAGE=$1
SOURCE_PATH=$2
BIN_DIR=$3       # Binary directory for Java compilation output
SOURCE_DIR=$4    # Source directory for Java source files
shift 4

compile_and_run() {
    case $1 in
        C)
            gcc "$2" -o exec 
            if [[ -n "$@" ]]; then
                PROGRAM="./exec $@"
            else
                PROGRAM="./exec"
            fi
            ;;
        C++)
            g++ "$2" -o exec
            if [[ -n "$@" ]]; then
                PROGRAM="./exec $@"
            else
                PROGRAM="./exec"
            fi
            ;;
        Fortran)
            gfortran "$2" -o exec
            if [[ -n "$@" ]]; then
                PROGRAM="./exec $@"
            else
                PROGRAM="./exec"
            fi
            ;;
        Java)
            javac -d "$BIN_DIR" -sourcepath "$SOURCE_DIR" "$2"
            class_name=$(basename "${2%.java}")
            PROGRAM="java -cp $BIN_DIR $class_name"
            ;;
        Rust)
            rustc "$2" -o exec
            if [[ -n "$@" ]]; then
                PROGRAM="./exec $@"
            else
                PROGRAM="./exec"
            fi
            ;;
        Erlang)
            erlc "$2"
            if [[ -n "$@" ]]; then
                executable_name="${2%.*}"
                PROGRAM="erl -noshell -run ${executable_name} main $@"
            else
                executable_name="${2%.*}"
                PROGRAM="erl -noshell -s ${executable_name} main -s init stop"
            fi
            ;;
        Python)
            PROGRAM="python3 $2"
            ;;
        Ruby)
            PROGRAM="ruby $2"
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
        
        sudo powerjoular -p $PROGRAM_PID >> $LANGUAGE-power_results.txt &
        POWERJOULAR_PID=$!

        sleep 60

        kill -INT $POWERJOULAR_PID
        echo "[Measure] - Done."
        kill -INT $PROGRAM_PID
    done
}

compile_and_run $LANGUAGE $SOURCE_PATH "$@"
if [-f exec]; then
    rm exec
fi
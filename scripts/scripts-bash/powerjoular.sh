#!/bin/bash

# Usage: ./script.sh <language> <source_path> [bin_dir] [source_dir] [args...]
# No args allowed

LANGUAGE=$1
SOURCE_PATH=$2
BIN_DIR=$3       # Binary directory for Java compilation output
SOURCE_DIR=$4    # Source directory for Java source files
shift 4

FILE_NAME=$(basename "${SOURCE_PATH%.*}")
RESULTS_FILE="${LANGUAGE}-power_results-${FILE_NAME}.txt"
DIRPATH=$(dirname "$SOURCE_PATH")

compile_and_run() {
    echo $@
    case $1 in
        c)
            gcc "$2" -o exec
            PROGRAM="./exec"
            ;;
        c++)
            g++ "$2" -o exec
            PROGRAM="./exec"
            ;;
        fortran)
            gfortran "$2" -o exec
            PROGRAM="./exec"
            ;;
        java)
            javac -d "$BIN_DIR" -sourcepath "$SOURCE_DIR" "$2"
            class_name=$(basename "${2%.java}")
            PROGRAM="java -cp $BIN_DIR $class_name"
            ;;
        rust)
            rustc "$2" -o exec
            PROGRAM="./exec"
            ;;
        erlang)
            cd $DIRPATH
            erlc "$FILE_NAME.erl"
            executable_name="${2%.*}"
            PROGRAM="erl -noshell -s $FILE_NAME main -s init stop"
            ;;
        python)
            PROGRAM="python3 $2"
            ;;
        ruby)
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

        sudo powerjoular -tp $PROGRAM_PID >> "$RESULTS_FILE" &
        POWERJOULAR_PID=$!

        sleep 60

        kill -INT $POWERJOULAR_PID
        echo "[Measure] - Done."
        kill -9 $PROGRAM_PID
    done
}

compile_and_run $LANGUAGE $SOURCE_PATH "$@"
if [ -f exec ]; then
    rm exec
fi
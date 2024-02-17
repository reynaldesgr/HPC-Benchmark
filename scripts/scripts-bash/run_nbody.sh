#!/bin/bash

ARGS=$1

LANGUAGES=("c" "cpp" "java" "python" "ruby" "erlang" "fortran" "rust")
for LANGUAGE in "${LANGUAGES[@]}"; do

    TIME_FILE="${LANGUAGE}_time.txt"
    BASE_DIR="../../${LANGUAGE}/n-body"

    case $LANGUAGE in
    "c")
        FILE="${BASE_DIR}/nbody.c"
        COMPILE_CMD="gcc -o ${BASE_DIR}/nbody ${FILE} -lm"
        RUN_CMD="${BASE_DIR}/nbody ${ARGS}"
        ;;
    "cpp"|"c++")
        FILE="${BASE_DIR}/nbody.cpp"
        COMPILE_CMD="g++ -o ${BASE_DIR}/nbody ${FILE} -lm"
        RUN_CMD="${BASE_DIR}/nbody ${ARGS}"
        ;;
    "java")
        FILE="${BASE_DIR}/nbody.java"
        COMPILE_CMD="javac ${FILE}"
        RUN_CMD="java -cp ${BASE_DIR} nbody ${ARGS}"
        ;;
    "python")
        FILE="${BASE_DIR}/nbody.py"
        RUN_CMD="python3 ${FILE} ${ARGS}"
        ;;
    "ruby")
        FILE="${BASE_DIR}/nbody.rb"
        RUN_CMD="ruby ${FILE} ${ARGS}"
        ;;
    "fortran")
      FILE="${BASE_DIR}/nbody.f90"
      COMPILE_CMD="gfortran -o ${BASE_DIR}/nbody ${FILE}"
      RUN_CMD="${BASE_DIR}/nbody ${ARGS}"
      ;;
    "erlang")
      FILE="${BASE_DIR}/nbody.erl"
      COMPILE_CMD="erlc -o ${BASE_DIR} ${FILE}"
      RUN_CMD="erl -noshell -s nbody main ${ARGS} -s init stop"
      ;;
    "rust")
      FILE="${BASE_DIR}/nbody.rs"
      COMPILE_CMD="rustc -o ${BASE_DIR}/nbody ${FILE}"
      RUN_CMD="${BASE_DIR}/nbody ${ARGS}"
      ;;
    *)
        exit 1
    esac

    if [[ ! -z "${COMPILE_CMD}" ]]; then
        echo "[$LANGUAGE] - Compilation..."
        { time ${COMPILE_CMD}; } 2>> "${TIME_FILE}"
        if [ $? -ne 0 ]; then
        echo "[$LANGUAGE] - Error on compilation"
        continue
        fi
    fi

    echo "Execution..."
    { time ${RUN_CMD}; } &>> "${TIME_FILE}"
done



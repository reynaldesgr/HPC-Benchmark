#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Usage: $0 <language_name> <compiler>"
  exit 1
fi

language=$1
compiler=$2
args=$3
source_file="../../$language/calculus/matrix"
executable="../../$language/calculus/matrix"

output_file="$language-execution_output-$args.txt"

compile_and_run() {
  source_path="$1"
  exec_path="$2"
  compile_flags="$3"
  echo $compiler $compile_flags -o "$exec_path" "$source_path"
  $compiler $compile_flags -o "$exec_path" "$source_path"
  chmod +x "$exec_path"
  "$exec_path" >> $output_file
}

case $language in
  "c")
    compile_and_run "${source_file}.c" "$executable" $args
    ;;
  "cpp")
    compile_and_run "${source_file}.cpp" "$executable"  $args
    ;;
  "rust"|"ruby"|"java"|"python"|"fortran"|"erlang")
    echo "Compilation not required or not supported directly by this script for $language."
    ;;
  *)
    echo "Unsupported language: $language"
    exit 1
    ;;
esac

echo "Execution output redirected to $language-$output_file"
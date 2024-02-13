#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 <language_name>"
  exit 1
fi

language=$1
executable="../../$language/calculus/matrix"

case $language in
  "c")
    extension=""
    ;;
  "cpp")
    extension=""
    ;;
  "rust")
    extension=""
    ;;
  "ruby")
    extension=".rb"
    ;;
  "java")
    executable="../../java/calculus/Matrix"
    extension=".java"
    ;;
  "python")
    extension=".py"
    ;;
  "fortran")
    extension=".out"
    ;;
  "erlang")
    extension=".erl"
    ;;
  *)
    exit 1
    ;;
esac

executable_path="$executable$extension"

echo "Execution : $executable_path" 
output_file="execution_output.txt"

case $language in
  "ruby"|"python"|"erlang")
    interpreter=""
    if [ "$language" = "ruby" ]; then
      interpreter="ruby"
    elif [ "$language" = "python" ]; then
      interpreter="python3"
    elif [ "$language" = "java" ]; then
      javac -d bin -sourcepath src ../../java/calculus/src/Matrix.java
      executable_path="../../java/calculus/bin Matrix"
    elif [ "$language" = "erlang" ]; then
      interpreter="erl -noshell -s matrix main -s init stop"
    fi
    $interpreter "$executable_path" > "$language-$output_file"
    ;;
  "java")
    java -cp "$executable_path" > "$language-$output_file"
    ;;
  *)
    chmod +x "$executable_path"
    "$executable_path" > "$language-$output_file"
    ;;
esac

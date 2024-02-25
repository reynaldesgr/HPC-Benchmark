#gfortran -o ../../fortran/binary-trees/binary_trees ../../fortran/binary-trees/*.f90
#echo "[Fortran] - Compiling sucess."
#python3 measure_program.py  "./../../fortran/binary-trees/binary_trees"
#echo "[Fortran] - Measure done"


echo "[Python] - Execution"
python3 measure_program.py "python3 ../../python/binary-trees/binary-trees.py"
echo "[Python] - Measure done"

#echo "[Ruby] - Execution"
#python3 measure_program.py "ruby ../../ruby/binary-trees/binary-trees.rb"
#echo "[Ruby] - Measure done"
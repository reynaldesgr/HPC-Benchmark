#!/bin/bash

# Nom de l'exécutable
EXECUTABLE=fibo_fortran

# Chemin vers le répertoire contenant les fichiers source
SOURCE_DIR=.

# Compiler tous les fichiers .f90 et générer l'exécutable
gfortran -o $EXECUTABLE $SOURCE_DIR/*.f90

# Vérifier si la compilation a réussi
if [ $? -eq 0 ]; then
  echo "Compilation réussie. Exécutable $EXECUTABLE généré."
else
  echo "Erreur de compilation."
fi

#include <stdio.h>
#include <time.h>
#include <math.h>
#include <sys/time.h>
#include <string.h>
#include "rapl.h"

#define RUNTIME 1

int main (int argc, char **argv) {
  char command[500] = "";
  int ntimes = 10;
  int core = 0;
  int i = 0;

#ifdef RUNTIME
  double time_spent;
  struct timeval tvb, tva;
#endif

  FILE *fp;
  char path[500] = "result.csv"; // Chemin fixe pour le fichier de sortie

  if (argc < 2) {
    printf("Usage: %s <executable_path>\n", argv[0]);
    return 1;
  }

  strcpy(command, argv[1]); // Prend l'exécutable comme argument

  fp = fopen(path, "a");

  if (fp == NULL) {
    perror("Erreur lors de l'ouverture du fichier");
    return 1;
  }

  rapl_init(core);

  for (i = 0; i < ntimes; i++) {
#ifdef RUNTIME
    gettimeofday(&tvb, NULL);
#endif

    rapl_before(fp, core);

    system(command);

    rapl_after(fp, core);

#ifdef RUNTIME
    gettimeofday(&tva, NULL);
    time_spent = (tva.tv_sec - tvb.tv_sec) * 1000000 + tva.tv_usec - tvb.tv_usec;
    time_spent /= 1000; // Conversion en millisecondes
    fprintf(fp, "%G\n", time_spent); // Enregistre le temps passé
#endif
  }

  fclose(fp);
  fflush(stdout);

  return 0;
}

#include <stdio.h>

int mandelbrot(double cr, double ci, int max_iter) {
    double zr = 0.0, zi = 0.0;
    int n = 0;
    while (zr*zr + zi*zi <= 4.0 && n < max_iter) {
        double temp = zr*zr - zi*zi + cr;
        zi = 2.0*zr*zi + ci;
        zr = temp;
        n++;
    }
    return n;
}

int main() {
    int size = 800, max_iter = 10000;
    FILE *fp = fopen("mandelbrot.csv", "w");
    if (fp == NULL) {
        printf("Erreur lors de l'ouverture du fichier\n");
        return 1;
    }

    for (int y = 0; y < size; y++) {
        for (int x = 0; x < size; x++) {
            double cr = 4.0*x/size - 2.0, ci = 4.0*y/size - 2.0;
            int m = mandelbrot(cr, ci, max_iter);
            fprintf(fp, "%d,", m);
        }
        fprintf(fp, "\n");
    }

    fclose(fp);
    return 0;
}

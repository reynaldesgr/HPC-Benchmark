#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void multiplyMatrices(double **a, double **b, double **result, int N) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            result[i][j] = 0;
            for (int k = 0; k < N; k++) {
                result[i][j] += a[i][k] * b[k][j];
            }
        }
    }
}

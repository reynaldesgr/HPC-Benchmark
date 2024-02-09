#include <stdio.h>
#include <stdlib.h>
#include <cblas.h>
#include <time.h>

#define N 500 

void fillMatrix(double *matrix, int n) {
    for (int i = 0; i < n * n; i++) {
        matrix[i] = rand() % 100; 
    }
}

int main() {
    double *A, *B, *C;
    clock_t start, end;
    double cpu_time_used;

    A = (double *)malloc(N * N * sizeof(double));
    B = (double *)malloc(N * N * sizeof(double));
    C = (double *)malloc(N * N * sizeof(double));

    fillMatrix(A, N);
    fillMatrix(B, N);

    start = clock();
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, N, N, N, 1.0, A, N, B, N, 0.0, C, N);
    end = clock();

    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Execution time with OpenBLAS: %f secondes\n", cpu_time_used);

    free(A);
    free(B);
    free(C);

    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 500 
void fillMatrix(int matrix[N][N]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            matrix[i][j] = rand() % 100; 
        }
    }
}

void multiplyMatrices(int firstMatrix[N][N], int secondMatrix[N][N], int result[N][N]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            result[i][j] = 0;
            for (int k = 0; k < N; k++) {
                result[i][j] += firstMatrix[i][k] * secondMatrix[k][j];
            }
        }
    }
}

int main() {
    int A[N][N], B[N][N], C[N][N];
    //clock_t start, end;
    //double cpu_time_used;

    fillMatrix(A);
    fillMatrix(B);

    //start = clock();
    multiplyMatrices(A, B, C);
    //end = clock();

    //cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;

    //printf("Execution time: %f secondes\n", cpu_time_used);

    return 0;
}

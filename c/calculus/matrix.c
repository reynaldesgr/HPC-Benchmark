#include <stdio.h>
#include <stdlib.h>

#define N 500 

void multiply(double a[N][N], double b[N][N], double result[N][N]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            result[i][j] = 0.0;
            for (int k = 0; k < N; k++) {
                result[i][j] += a[i][k] * b[k][j];
            }
        }
    }
}

int main() {
    double a[N][N]; 
    double b[N][N];
    double result[N][N];
    
    return 0;
}

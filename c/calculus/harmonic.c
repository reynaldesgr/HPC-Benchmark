#include <stdio.h>
#include <time.h>

double harmonic_sum(int n) {
    double sum = 0.0;
    for (int i = 1; i <= n; i++) {
        sum += 1.0 / i;
    }
    return sum;
}

int main() {
    int n = 10000000; // Example value
    //clock_t start = clock();
    double result = harmonic_sum(n);
    //clock_t end = clock();
    //double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Result: %f\n", result);
    //printf("Time used: %f seconds\n", cpu_time_used);
    return 0;
}

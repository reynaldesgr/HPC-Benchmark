#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ITERATIONS 100000000

void benchmark_float_operations() {
    float f1 = 1.234567f, f2 = 7.890123f;
    clock_t start, end;
    float result = 0.0f;

    start = clock();
    for (long i = 0; i < ITERATIONS; ++i) {
        result = f1 * f2;
    }
    end = clock();
    printf("Float multiplication: Result = %f, Time = %f seconds\n", result, (double)(end - start) / CLOCKS_PER_SEC);

    start = clock();
    for (long i = 0; i < ITERATIONS; ++i) {
        result = f1 + f2;
    }
    end = clock();
    printf("Float addition: Result = %f, Time = %f seconds\n", result, (double)(end - start) / CLOCKS_PER_SEC);

    start = clock();
    for (long i = 0; i < ITERATIONS; ++i) {
        result = f1 / f2;
    }
    end = clock();
    printf("Float division: Result = %f, Time = %f seconds\n", result, (double)(end - start) / CLOCKS_PER_SEC);
}

void benchmark_double_operations() {
    double d1 = 1.234567890123456, d2 = 7.890123456789012;
    clock_t start, end;
    double result = 0.0;

    start = clock();
    for (long i = 0; i < ITERATIONS; ++i) {
        result = d1 * d2;
    }
    end = clock();
    printf("Double multiplication: Result = %f, Time = %f seconds\n", result, (double)(end - start) / CLOCKS_PER_SEC);

    start = clock();
    for (long i = 0; i < ITERATIONS; ++i) {
        result = d1 + d2;
    }
    end = clock();
    printf("Double addition: Result = %f, Time = %f seconds\n", result, (double)(end - start) / CLOCKS_PER_SEC);

    start = clock();
    for (long i = 0; i < ITERATIONS; ++i) {
        result = d1 / d2;
    }
    end = clock();
    printf("Double division: Result = %f, Time = %f seconds\n", result, (double)(end - start) / CLOCKS_PER_SEC);
}

int main() {
    printf("Benchmarking float (32-bit) operations:\n");
    benchmark_float_operations();
    printf("\nBenchmarking double (64-bit) operations:\n");
    benchmark_double_operations();
    return 0;
}

/**
    Benchmarking float (32-bit) operations:
    Float multiplication: Result = 9.740886, Time = 0.060458 seconds
    Float addition: Result = 9.124690, Time = 0.036351 seconds
    Float division: Result = 0.156470, Time = 0.072349 seconds

    Benchmarking double (64-bit) operations:
    Double multiplication: Result = 9.740893, Time = 0.036679 seconds
    Double addition: Result = 9.124691, Time = 0.103726 seconds
    Double division: Result = 0.156470, Time = 0.142266 seconds
*/
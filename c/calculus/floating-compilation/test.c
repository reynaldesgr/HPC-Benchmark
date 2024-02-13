#include <stdio.h>

int main() {
    float a = 152568.47, b = 14114785.54;
    float result;

    result = a / b;
    printf("a / b : %f\n", result);

    result = a * b;
    printf("a * b: %f\n", result);

    result = a + b - b * a;
    printf("a + b - b * a: %f\n", result);

    result = a - b + b * a;
    printf("a + b - b * a: %f\n", result);

    result = a + b + a * b;
    printf("a + b + a * b: %f\n", result);

    result = a + b - a * b;
    printf("a + b - a * b: %f\n", result);

    result = a + b + a / b;
    printf("a + b + a / b: %f\n", result);

    result = a + b - a / b;
    printf("a + b - a / b: %f\n", result);

    result = a / (b + 1);
    printf("a / (b + 1): ): %f\n", result);

    result = (a + b) / (a - b);
    printf("(a + b) / (a - b): %f\n", result);

    result = (a - b) / (a + b);
    printf("(a - b) / (a + b): %f\n", result);

    result = (a * b) / (a + b);
    printf("(a * b) / (a + b): %f\n", result);

    result = (a * b) / (a - b);
    printf("(a * b) / (a - b): %f\n", result);

    return 0;
}

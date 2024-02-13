#include <stdio.h>

int main() {
    float a = 152568.47, b = 14114785.54;
    float result;

    result = a / b;
    printf("Division: %f\n", result);

    result = a * b;
    printf("Multiplication: %f\n", result);

    result = a + b - b * a;
    printf("Addition, Subtraction, Multiplication: %f\n", result);

    result = a - b + b * a;
    printf("Subtraction, Addition, Multiplication: %f\n", result);

    result = a + b + a * b;
    printf("Addition, Addition, Multiplication: %f\n", result);

    result = a + b - a * b;
    printf("Addition, Addition, Multiplication: %f\n", result);

    result = a + b + a / b;
    printf("Addition, Addition, Division: %f\n", result);

    result = a + b - a / b;
    printf("Addition, Subtraction, Division: %f\n", result);

    result = a / (b + 1);
    printf("Division by (b + 1): %f\n", result);

    result = (a + b) / (a - b);
    printf("Division of (a + b) by (a - b): %f\n", result);

    result = (a - b) / (a + b);
    printf("Division of (a + b) by (a - b): %f\n", result);

    result = (a * b) / (a + b);
    printf("Division of (a * b) by (a + b): %f\n", result);

    result = (a * b) / (a - b);
    printf("Division of (a * b) by (a - b): %f\n", result);

    return 0;
}

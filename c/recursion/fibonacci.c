#include <stdio.h>
#include <time.h>

long long fibonacci(int n)
{
    if (n <= 1)
    {
        return n;
    }
    else
    {
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
}


int main()
{
    long long r = fibonacci(45);

    printf("C result : %lld\n", r);
    
    return 0;
}
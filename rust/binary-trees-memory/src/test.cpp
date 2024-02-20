#include <stdio.h>


struct Toto
{
    bool a;
    int  b;
    bool c;
};

int main(int argc, char const *argv[])
{
    printf("int %zu\n", sizeof(int));
    printf("Toto %zu\n", sizeof(Toto));
    return 0;
}

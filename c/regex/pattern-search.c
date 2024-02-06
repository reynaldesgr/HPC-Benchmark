#include <stdio.h>
#include <stdbool.h>

bool find(const char *pattern, const char *text) 
{
    while (*text) 
    {
        const char *p = pattern;
        const char *t = text;

        while (*p && *p == *t) 
        {
            p++;
            t++;
        }

        if (!*p) 
        {
            return true;
        }

        text++;
    }

    return false;
}

int main() {
    const char *pattern = "ferm";
    const char *text    = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus nec lorem a nulla cursus vehicula. Integer euismod ligula ut nulla convallis, nec gravida erat vehicula. In nec tristique odio. Praesent condimentum venenatis purus, sit amet euismod lectus tincidunt id. Duis et cursus velit. Fusce sed sapien ante. Sed vitae ullamcorper odio. Donec volutpat id nulla nec laoreet. Integer vel libero a justo bibendum euismod. Etiam in ligula sed nisi pellentesque consequat. Suspendisse potenti. Curabitur euismod felis et felis fermentum, id tincidunt nunc tempor. Morbi congue massa et mi sodales interdum. Fusce pharetra est eget justo ultrices congue. Quisque at hendrerit justo. Nam nec mauris eu sapien viverra venenatis. Nulla facilisi. Nullam id ligula ut quam tempor rhoncus nec at libero. Quisque sit amet arcu dui";

    find(pattern, text);

    return 0;
}

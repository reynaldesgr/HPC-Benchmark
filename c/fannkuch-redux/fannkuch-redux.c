#include <stdio.h>
#include <stdlib.h>

int fannkuch(int n) {
    int *perm  = malloc(n * sizeof(int));
    int *perm1 = malloc(n * sizeof(int));
    int *count = malloc(n * sizeof(int));
    int maxFlips = 0, permCount = 0, checksum = 0;

    // Initialize perm1 with 1 to n
    for (int i = 0; i < n; i++) {
        perm1[i] = i;
    }

    int r = n;

    while (1) {
        while (r != 1) {
            count[r-1] = r;
            r--;
        }

        // Copy perm1 to perm
        for (int i = 0; i < n; i++) {
            perm[i] = perm1[i];
        }

        int flipsCount = 0;
        int k;

        while ((k = perm[0]) != 0) {
            // k is the first number in the array, so we flip perm[0]...perm[k]
            int k2 = (k + 1) >> 1;
            for (int i = 0; i < k2; i++) {
                int temp = perm[i];
                perm[i] = perm[k - i];
                perm[k - i] = temp;
            }
            flipsCount++;
        }

        maxFlips = flipsCount > maxFlips ? flipsCount : maxFlips;
        permCount++;

        // Generate next permutation
        while (1) {
            if (r == n) {
                free(perm);
                free(perm1);
                free(count);
                return maxFlips;
            }

            int perm0 = perm1[0];
            int i = 0;
            while (i < r) {
                int j = i + 1;
                perm1[i] = perm1[j];
                i = j;
            }
            perm1[r] = perm0;

            count[r] = count[r] - 1;
            if (count[r] > 0) break;
            r++;
        }
    }
}

int main() {
    int n = 12;
    printf("Maximum flips for n=%d is %d\n", n, fannkuch(n));
    return 0;
}

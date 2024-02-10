#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "mtwister.h"

#define SIZE 40
#define ITERATIONS 10

#define EMPTY 0
#define TREE 1
#define FIRE 2

void initialize_forest(int forest[SIZE][SIZE], MTRand *rng) {
    for (int i = 0; i < SIZE; ++i) {
        for (int j = 0; j < SIZE; ++j) {
            forest[i][j] = genRand(rng) < 0.6 ? TREE : EMPTY; 
        }
    }
}

void print_forest(FILE *fp, int forest[SIZE][SIZE]) {
    for (int i = 0; i < SIZE; ++i) {
        for (int j = 0; j < SIZE; ++j) {
            fprintf(fp, "%c ", forest[i][j] == EMPTY ? '.' : (forest[i][j] == TREE ? 'T' : 'F'));
        }
        fprintf(fp, "\n");
    }
}

void simulate_fire(int forest[SIZE][SIZE], MTRand *rng) {
    int next_forest[SIZE][SIZE];

    for (int i = 0; i < SIZE; ++i) {
        for (int j = 0; j < SIZE; ++j) {
            if (forest[i][j] == TREE) {
                if ((i > 0 && forest[i - 1][j] == FIRE) || (i < SIZE - 1 && forest[i + 1][j] == FIRE) ||
                    (j > 0 && forest[i][j - 1] == FIRE) || (j < SIZE - 1 && forest[i][j + 1] == FIRE)) {
                    next_forest[i][j] = FIRE;
                } else {
                    next_forest[i][j] = TREE;
                }
            } else if (forest[i][j] == FIRE) {
                next_forest[i][j] = EMPTY;
                if (i > 0 && forest[i - 1][j] == TREE)
                    next_forest[i - 1][j] = FIRE;
                if (i < SIZE - 1 && forest[i + 1][j] == TREE)
                    next_forest[i + 1][j] = FIRE;
                if (j > 0 && forest[i][j - 1] == TREE)
                    next_forest[i][j - 1] = FIRE;
                if (j < SIZE - 1 && forest[i][j + 1] == TREE)
                    next_forest[i][j + 1] = FIRE;
            } else {
                next_forest[i][j] = EMPTY;
            }
        }
    }

    for (int i = 0; i < SIZE; ++i) {
        for (int j = 0; j < SIZE; ++j) {
            forest[i][j] = next_forest[i][j];
        }
    }
}

int main() {
    MTRand rng;
    m_seedRand(&rng, 124723);

    int forest[SIZE][SIZE];

    initialize_forest(forest, &rng);

    forest[SIZE / 2][SIZE / 2] = FIRE;

    FILE *fp = fopen("forest_output.txt", "w");
    if (fp == NULL) {
        fprintf(stderr, "Erreur lors de l'ouverture du fichier.\n");
        return 1;
    }

    print_forest(fp, forest);
    fprintf(fp, "\n");

    for (int i = 0; i < ITERATIONS; ++i) 
    {
        simulate_fire(forest, &rng);
        print_forest(fp, forest);
        fprintf(fp, "\n");
    }

    fclose(fp);

    return 0;
}

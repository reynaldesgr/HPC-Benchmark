#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SEQUENCE_LENGTH 50
#define NUM_SEQUENCES 5

/* Function to generate a single random DNA base */
char generate_random_base() {
    char bases[] = {'A', 'C', 'G', 'T'};
    return bases[rand() % 4]; // Randomly choose a base
}

/* Function to generate a random DNA sequence */
void generate_dna_sequence(char *sequence, int length) {
    for (int i = 0; i < length; i++) {
        sequence[i] = generate_random_base();
    }
    sequence[length] = '\0'; // Null-terminate the string
}

/* Function to write sequences to a FASTA file */
void write_fasta(char sequences[NUM_SEQUENCES][SEQUENCE_LENGTH + 1], const char *filename) {
    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        fprintf(stderr, "Error opening file %s for writing\n", filename);
        exit(1);
    }

    for (int i = 0; i < NUM_SEQUENCES; i++) {
        fprintf(file, ">seq%d\n", i + 1);
        fprintf(file, "%s\n", sequences[i]);
    }

    fclose(file);
}

int main() {
    char sequences[NUM_SEQUENCES][SEQUENCE_LENGTH + 1]; // +1 for the null terminator
    srand(time(NULL)); // Seed the random number generator

    // Generate random DNA sequences
    for (int i = 0; i < NUM_SEQUENCES; i++) {
        generate_dna_sequence(sequences[i], SEQUENCE_LENGTH);
    }

    // Write the sequences to a FASTA file
    write_fasta(sequences, "random_dna_sequences.fasta");

    printf("Generated %d random DNA sequences of length %d and saved to random_dna_sequences.fasta\n", NUM_SEQUENCES, SEQUENCE_LENGTH);
    return 0;
}

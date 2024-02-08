import random

def generate_dna_sequence(length):
    """Generate a random DNA sequence of given length."""
    return ''.join(random.choice('ACGT') for _ in range(length))

def write_fasta(sequences, filename):
    """Write sequences to a FASTA file."""
    with open(filename, 'w') as file:
        for i, seq in enumerate(sequences, start=1):
            file.write(f">seq{i}\n{seq}\n")

def main():
    num_sequences = 5  # Number of sequences to generate
    sequence_length = 50  # Length of each sequence
    fasta_filename = "random_dna_sequences.fasta"
    
    sequences = [generate_dna_sequence(sequence_length) for _ in range(num_sequences)]
    write_fasta(sequences, fasta_filename)
    print(f"Generated {num_sequences} random DNA sequences of length {sequence_length} and saved to {fasta_filename}")

if __name__ == "__main__":
    main()
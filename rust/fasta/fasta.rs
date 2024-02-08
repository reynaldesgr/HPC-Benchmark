use rand::distributions::{Distribution, Uniform};
use std::fs::File;
use std::io::{Result, Write};

fn main() -> Result<()> {
    let num_sequences = 5;
    let sequence_length = 50;
    let fasta_filename = "random_dna_sequences.fasta";

    let mut file = File::create(fasta_filename)?;

    for i in 0..num_sequences {
        let sequence = generate_random_dna_sequence(sequence_length);
        writeln!(file, ">seq{}", i + 1)?;
        writeln!(file, "{}", sequence)?;
    }

    Ok(())
}

fn generate_random_dna_sequence(length: usize) -> String {
    let bases = ['A', 'C', 'G', 'T'];
    let mut rng = rand::thread_rng();
    let dist = Uniform::from(0..bases.len());

    (0..length)
        .map(|_| bases[dist.sample(&mut rng)])
        .collect()
}

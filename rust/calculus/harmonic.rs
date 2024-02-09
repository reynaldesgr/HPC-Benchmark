use std::time::Instant;

fn harmonic_sum(n: usize) -> f64 {
    (1..=n).fold(0.0, |sum, i| sum + 1.0 / i as f64)
}

fn main() {
    let n = 10_000_000; 
    let result = harmonic_sum(n);
    println!("Result: {}", result);
}

use std::time::Instant;

const ITERATIONS: usize = 100000000;

fn benchmark_float_operations() {
    let f1: f32 = 1.234567;
    let f2: f32 = 7.890123;
    let start = Instant::now();
    for _ in 0..ITERATIONS {
        let _result = f1 * f2;
    }
    let end = Instant::now();
    println!("Float multiplication: Time = {:.9} seconds", (end - start).as_secs_f64());

    let start = Instant::now();
    for _ in 0..ITERATIONS {
        let _result = f1 + f2;
    }
    let end = Instant::now();
    println!("Float addition: Time = {:.9} seconds", (end - start).as_secs_f64());

    let start = Instant::now();
    for _ in 0..ITERATIONS {
        let _result = f1 / f2;
    }
    let end = Instant::now();
    println!("Float division: Time = {:.9} seconds", (end - start).as_secs_f64());
}

fn benchmark_double_operations() {
    let d1: f64 = 1.234567890123456;
    let d2: f64 = 7.890123456789012;
    let start = Instant::now();
    for _ in 0..ITERATIONS {
        let _result = d1 * d2;
    }
    let end = Instant::now();
    println!("Double multiplication: Time = {:.9} seconds", (end - start).as_secs_f64());

    let start = Instant::now();
    for _ in 0..ITERATIONS {
        let _result = d1 + d2;
    }
    let end = Instant::now();
    println!("Double addition: Time = {:.9} seconds", (end - start).as_secs_f64());

    let start = Instant::now();
    for _ in 0..ITERATIONS {
        let _result = d1 / d2;
    }
    let end = Instant::now();
    println!("Double division: Time = {:.9} seconds", (end - start).as_secs_f64());
}

fn main() {
    println!("Benchmarking float (32-bit) operations:");
    benchmark_float_operations();
    println!("\nBenchmarking double (64-bit) operations:");
    benchmark_double_operations();
}

/**
Benchmarking float (32-bit) operations:
Float multiplication: Time = 0.214517730 seconds
Float addition: Time = 0.189963891 seconds
Float division: Time = 0.210712662 seconds

Benchmarking double (64-bit) operations:
Double multiplication: Time = 0.212124171 seconds
Double addition: Time = 0.192498492 seconds
Double division: Time = 0.212975054 seconds
**/

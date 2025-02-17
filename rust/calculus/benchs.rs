use std::time::Instant;

const ITERATIONS: usize = 100000000;

fn benchmark_float_operations() {
    let f1: f32 = 1.234567;
    let f2: f32 = 7.890123;
    let mut result = 0.0; 

    let start = Instant::now();
    for _ in 0..ITERATIONS {
        result = f1 * f2;
    }
    let end = Instant::now();
    println!("Float multiplication: Time = {:.6} seconds, Result = {:.6}", (end - start).as_secs_f64(), result);

    let start = Instant::now();
    for _ in 0..ITERATIONS {
        result = f1 + f2; 
    }
    let end = Instant::now();
    println!("Float addition: Time = {:.6} seconds, Result = {:.6}", (end - start).as_secs_f64(), result);

    let start = Instant::now();
    for _ in 0..ITERATIONS {
        result = f1 / f2; 
    }
    let end = Instant::now();
    println!("Float division: Time = {:.6} seconds, Result = {:.6}", (end - start).as_secs_f64(), result);
}

fn benchmark_double_operations() {
    let d1: f64 = 1.234567890123456;
    let d2: f64 = 7.890123456789012;
    let mut result = 0.0; 

    let start = Instant::now();
    for _ in 0..ITERATIONS {
        result = d1 * d2; 
    }
    let end = Instant::now();
    println!("Double multiplication: Time = {:.6} seconds, Result = {:.6}", (end - start).as_secs_f64(), result);

    let start = Instant::now();
    for _ in 0..ITERATIONS {
        result = d1 + d2;
    }
    let end = Instant::now();
    println!("Double addition: Time = {:.6} seconds, Result = {:.6}", (end - start).as_secs_f64(), result);

    let start = Instant::now();
    for _ in 0..ITERATIONS {
        result = d1 / d2;
    }
    let end = Instant::now();
    println!("Double division: Time = {:.6} seconds, Result = {:.6}", (end - start).as_secs_f64(), result);
}

fn main() {
    println!("Benchmarking float (32-bit) operations:");
    benchmark_float_operations();
    println!("\nBenchmarking double (64-bit) operations:");
    benchmark_double_operations();
}

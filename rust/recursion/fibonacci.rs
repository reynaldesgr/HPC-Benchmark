fn fibonacci(n: u64) -> u64
{
    match n
    {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
}

fn main()
{
    let res = fibonacci(45);
    println!("Rust result : {}", res);
}
use std::fs::File;
use std::io::{BufWriter, Write};

fn mandelbrot(cr: f64, ci: f64, max_iter: usize) -> usize {
    let (mut zr, mut zi, mut zr2, mut zi2) = (0.0, 0.0, 0.0, 0.0);
    let mut n = 0;
    while zr2 + zi2 <= 4.0 && n < max_iter {
        zi = 2.0 * zr * zi + ci;
        zr = zr2 - zi2 + cr;
        zr2 = zr * zr;
        zi2 = zi * zi;
        n += 1;
    }
    n
}

fn main() -> std::io::Result<()> {
    let size = 800usize;
    let max_iter = 16000;
    let mut data = Vec::with_capacity(size * size);
    
    for y in 0..size {
        for x in 0..size {
            let cr = 4.0 * x as f64 / size as f64 - 2.0;
            let ci = 4.0 * y as f64 / size as f64 - 2.0;
            data.push(mandelbrot(cr, ci, max_iter));
        }
    }

    let file = File::create("mandelbrot_rust.csv")?;
    let mut writer = BufWriter::new(file);
    
    for y in 0..size {
        for x in 0..size {
            write!(writer, "{},", data[y * size + x])?;
        }
        writeln!(writer)?;
    }
    Ok(())
}

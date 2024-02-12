fn multiply(a: &Vec<Vec<f64>>, b: &Vec<Vec<f64>>) -> Vec<Vec<f64>> {
    let n = a.len();
    let mut result = vec![vec![0.0; n]; n];

    for i in 0..n {
        for j in 0..n {
            for k in 0..n {
                result[i][j] += a[i][k] * b[k][j];
            }
        }
    }

    result
}

fn main() {
    let n = 500;
    let a: Vec<Vec<f64>> = vec![vec![0.0; n]; n]; // Initialize these matrices with your data
    let b: Vec<Vec<f64>> = vec![vec![0.0; n]; n];
    let result = multiply(&a, &b);
}

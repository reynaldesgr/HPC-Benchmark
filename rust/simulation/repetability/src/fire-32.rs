use std::fs::File;
use std::io::prelude::*;
use rand_mt::Mt19937GenRand32;

const SIZE: usize = 40;
const ITERATIONS: usize = 10;

const EMPTY: usize = 0;
const TREE: usize = 1;
const FIRE: usize = 2;

fn initialize_forest(_rng: &mut Mt19937GenRand32) -> Vec<Vec<usize>> {
    let threshold = (u32::MAX / 10) * 6; // Seuil pour déterminer la probabilité d'avoir un arbre
    (0..SIZE)
        .map(|_| {
            (0..SIZE)
                .map(|_| if _rng.next_u32() < threshold { TREE } else { EMPTY })
                .collect()
        })
        .collect()
}

fn print_forest_to_file(forest: &[Vec<usize>], file: &mut File) {
    for row in forest {
        let row_str: String = row
            .iter()
            .map(|cell| match cell {
                &EMPTY => '.',
                &TREE => 'T',
                &FIRE => 'F',
                _ => unreachable!(),
            })
            .collect();
        writeln!(file, "{}", row_str).expect("Error writing to file");
    }
}

fn simulate_fire(forest: &mut Vec<Vec<usize>>, _rng: &mut Mt19937GenRand32) {
    let mut next_forest = forest.clone();

    for i in 0..SIZE {
        for j in 0..SIZE {
            if forest[i][j] == TREE {
                if (i > 0 && forest[i - 1][j] == FIRE)
                    || (i < SIZE - 1 && forest[i + 1][j] == FIRE)
                    || (j > 0 && forest[i][j - 1] == FIRE)
                    || (j < SIZE - 1 && forest[i][j + 1] == FIRE)
                {
                    next_forest[i][j] = FIRE;
                }
            } else if forest[i][j] == FIRE {
                next_forest[i][j] = EMPTY;
                if i > 0 && forest[i - 1][j] == TREE {
                    next_forest[i - 1][j] = FIRE;
                }
                if i < SIZE - 1 && forest[i + 1][j] == TREE {
                    next_forest[i + 1][j] = FIRE;
                }
                if j > 0 && forest[i][j - 1] == TREE {
                    next_forest[i][j - 1] = FIRE;
                }
                if j < SIZE - 1 && forest[i][j + 1] == TREE {
                    next_forest[i][j + 1] = FIRE;
                }
            }
        }
    }

    *forest = next_forest;
}

fn main() {
    let mut _rng = Mt19937GenRand32::new(4136);
    let mut forest = initialize_forest(&mut _rng);
    forest[SIZE / 2][SIZE / 2] = FIRE;

    let mut file = File::create("forest_output.txt").expect("Error creating file");

    print_forest_to_file(&forest, &mut file);
    writeln!(&mut file, "").expect("Error writing to file");

    for _ in 0..ITERATIONS {
        simulate_fire(&mut forest, &mut _rng);
        print_forest_to_file(&forest, &mut file);
        writeln!(&mut file, "").expect("Error writing to file");
    }
}

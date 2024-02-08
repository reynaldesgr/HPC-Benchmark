fn fannkuch(n: usize) -> (usize, usize, usize) {
    // Generate the initial permutation of numbers from 1 to n
    let mut perm: Vec<usize> = (1..=n).collect();
    let mut count: Vec<usize> = vec![0; n + 1];
    let mut max_flips = 0;
    let mut total_flips = 0;
    let mut perm_count = 0;

    loop {
        // Check if the first element is not 1 (since we want to count flips)
        if perm[0] != 1 {
            let mut flips_count = 0;
            let range_to_reverse = perm[0];
            let mut perm_copy = perm.clone();
            perm_copy[..range_to_reverse].reverse();
            while perm_copy[0] != 1 {
                perm_copy[..range_to_reverse].reverse();
                flips_count += 1;
            }
            max_flips = max_flips.max(flips_count);
            total_flips += flips_count;
        }

        // Generate the next permutation
        let mut i = 1;
        while i < n {
            count[i] += 1;
            if count[i] > i {
                count[i] = 0;
                perm.swap(i, i + 1);
                i += 1;
            } else {
                break;
            }
        }

        if i == n {
            break;
        }

        perm_count += 1;
    }

    (max_flips, total_flips, perm_count)
}

fn main() {
    let n = 12;
    let (max_flips, total_flips, perm_count) = fannkuch(n);
    println!("Maximum flips: {}, Total flips: {}, Permutations: {}", max_flips, total_flips, perm_count);
}

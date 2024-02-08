def fannkuch(n):
    # Generate the initial permutation of numbers from 1 to n
    perm = list(range(1, n + 1))
    count = [0] * (n + 1)
    max_flips = 0
    total_flips = 0
    perm_count = 0

    while True:
        # Check if the first element is not 1 (since we want to count flips)
        if perm[0] != 1:
            flips_count = 0
            perm_copy = perm[:]
            while perm_copy[0] != 1:
                perm_copy[:perm_copy[0]] = reversed(perm_copy[:perm_copy[0]])
                flips_count += 1
            max_flips = max(max_flips, flips_count)
            total_flips += flips_count

        # Generate the next permutation
        i = 1
        while i < n:
            count[i] += 1
            if count[i] > i:
                count[i] = 0
                perm = perm[:i] + [perm[i+1]] + [perm[i]] + perm[i+2:]
                i += 1
            else:
                break
        else:
            break
        perm_count += 1

    return max_flips, total_flips, perm_count

n = 12
max_flips, total_flips, perm_count = fannkuch(n)
print(f"Maximum flips: {max_flips}, Total flips: {total_flips}, Permutations: {perm_count}")

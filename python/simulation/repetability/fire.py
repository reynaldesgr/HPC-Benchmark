import numpy as np

SIZE = 40
ITERATIONS = 10

EMPTY = 0
TREE = 1
FIRE = 2

def initialize_forest(rng):
    return rng.choice([EMPTY, TREE], size=(SIZE, SIZE), p=[0.4, 0.6])

def print_forest_to_file(forest, file):
    for row in forest:
        file.write(" ".join('.' if cell == EMPTY else ('T' if cell == TREE else 'F') for cell in row) + "\n")

def simulate_fire(forest, rng):
    next_forest = np.copy(forest)

    for i in range(SIZE):
        for j in range(SIZE):
            if forest[i, j] == TREE:
                if (i > 0 and forest[i - 1, j] == FIRE) or \
                   (i < SIZE - 1 and forest[i + 1, j] == FIRE) or \
                   (j > 0 and forest[i, j - 1] == FIRE) or \
                   (j < SIZE - 1 and forest[i, j + 1] == FIRE):
                    next_forest[i, j] = FIRE
            elif forest[i, j] == FIRE:
                next_forest[i, j] = EMPTY
                if i > 0 and forest[i - 1, j] == TREE:
                    next_forest[i - 1, j] = FIRE
                if i < SIZE - 1 and forest[i + 1, j] == TREE:
                    next_forest[i + 1, j] = FIRE
                if j > 0 and forest[i, j - 1] == TREE:
                    next_forest[i, j - 1] = FIRE
                if j < SIZE - 1 and forest[i, j + 1] == TREE:
                    next_forest[i, j + 1] = FIRE

    return next_forest

def main():
    rng = np.random.Generator(np.random.MT19937(124723))

    forest = initialize_forest(rng)
    forest[SIZE // 2, SIZE // 2] = FIRE

    with open("forest_output.txt", "w") as file:
        print_forest_to_file(forest, file)
        file.write("\n")

        for i in range(ITERATIONS):
            forest = simulate_fire(forest, rng)
            print_forest_to_file(forest, file)
            file.write("\n")

if __name__ == "__main__":
    main()

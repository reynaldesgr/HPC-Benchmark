import numpy as np
import time

N = 500   

def fillMatrix(n):
    return np.random.randint(100, size=(n, n))

def main():
    A = fillMatrix(N)
    B = fillMatrix(N)

    start = time.time()
    C = np.dot(A, B)
    end = time.time()

    cpu_time_used = end - start

    print(f"Temps d'exécution: {cpu_time_used} secondes")

if __name__ == "__main__":
    main()

import time

def harmonic_sum(n):
    return sum(1.0 / i for i in range(1, n + 1))

n = 10000000 
result = harmonic_sum(n)
print(f"Result: {result}")

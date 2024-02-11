import time

ITERATIONS = 100000000

def benchmark_float_operations():
    f1, f2 = 1.234567, 7.890123
    start = time.time()
    for i in range(ITERATIONS):
        result = f1 * f2
    end = time.time()
    print(f"Float multiplication: Result = {result:.6f}, Time = {end - start:.6f} seconds")

    start = time.time()
    for i in range(ITERATIONS):
        result = f1 + f2
    end = time.time()
    print(f"Float addition: Result = {result:.6f}, Time = {end - start:.6f} seconds")

    start = time.time()
    for i in range(ITERATIONS):
        result = f1 / f2
    end = time.time()
    print(f"Float division: Result = {result:.6f}, Time = {end - start:.6f} seconds")

def benchmark_double_operations():
    d1, d2 = 1.234567890123456, 7.890123456789012
    start = time.time()
    for i in range(ITERATIONS):
        result = d1 * d2
    end = time.time()
    print(f"Double multiplication: Result = {result:.6f}, Time = {end - start:.6f} seconds")

    start = time.time()
    for i in range(ITERATIONS):
        result = d1 + d2
    end = time.time()
    print(f"Double addition: Result = {result:.6f}, Time = {end - start:.6f} seconds")

    start = time.time()
    for i in range(ITERATIONS):
        result = d1 / d2
    end = time.time()
    print(f"Double division: Result = {result:.6f}, Time = {end - start:.6f} seconds")

print("Benchmarking float (32-bit) operations:")
benchmark_float_operations()
print("\nBenchmarking double (64-bit) operations:")
benchmark_double_operations()

'''
    Benchmarking float (32-bit) operations:
    Float multiplication: Result = 9.740885, Time = 3.244994 seconds
    Float addition: Result = 9.124690, Time = 2.677444 seconds
    Float division: Result = 0.156470, Time = 2.772597 seconds

    Benchmarking double (64-bit) operations:
    Double multiplication: Result = 9.740893, Time = 2.767900 seconds
    Double addition: Result = 9.124691, Time = 2.684509 seconds
    Double division: Result = 0.156470, Time = 2.676056 seconds

'''
import time

ITERATIONS = 100000000

def benchmark_float_operations():
    f1, f2 = 1.234567, 7.890123
    start = time.time()
    for i in range(ITERATIONS):
        result = f1 * f2
    end = time.time()
    print("Float multiplication: Result = {}, Time = {} seconds".format(result, end - start))

    start = time.time()
    for i in range(ITERATIONS):
        result = f1 + f2
    end = time.time()
    print("Float addition: Result = {}, Time = {} seconds".format(result, end - start))

    start = time.time()
    for i in range(ITERATIONS):
        result = f1 / f2
    end = time.time()
    print("Float division: Result = {}, Time = {} seconds".format(result, end - start))

def benchmark_double_operations():
    d1, d2 = 1.234567890123456, 7.890123456789012
    start = time.time()
    for i in range(ITERATIONS):
        result = d1 * d2
    end = time.time()
    print("Double multiplication: Result = {}, Time = {} seconds".format(result, end - start))

    start = time.time()
    for i in range(ITERATIONS):
        result = d1 + d2
    end = time.time()
    print("Double addition: Result = {}, Time = {} seconds".format(result, end - start))

    start = time.time()
    for i in range(ITERATIONS):
        result = d1 / d2
    end = time.time()
    print("Double division: Result = {}, Time = {} seconds".format(result, end - start))

print("Benchmarking float (32-bit) operations:")
benchmark_float_operations()
print("\nBenchmarking double (64-bit) operations:")
benchmark_double_operations()


'''
Benchmarking float (32-bit) operations:
Float multiplication: Result = 9.740885481741, Time = 1.6514379978179932 seconds
Float addition: Result = 9.12469, Time = 1.7578771114349365 seconds
Float division: Result = 0.1564699308236386, Time = 1.8881797790527344 seconds

Benchmarking double (64-bit) operations:
Double multiplication: Result = 9.7408930688616, Time = 1.7212166786193848 seconds
Double addition: Result = 9.124691346912467, Time = 1.8477880954742432 seconds
Double division: Result = 0.15647003457989989, Time = 1.8873770236968994 seconds
'''
public class Benchmark {

    private static final long ITERATIONS = 100000000L;

    public static void benchmarkFloatOperations() {
        float f1 = 1.234567f, f2 = 7.890123f;
        float result = 0.0f;

        long start = System.nanoTime();
        for (long i = 0; i < ITERATIONS; ++i) {
            result = f1 * f2;
        }
        long end = System.nanoTime();
        System.out.printf("Float multiplication: Result = %f, Time = %f seconds%n", result, (end - start) / 1e9);

        start = System.nanoTime();
        for (long i = 0; i < ITERATIONS; ++i) {
            result = f1 + f2;
        }
        end = System.nanoTime();
        System.out.printf("Float addition: Result = %f, Time = %f seconds%n", result, (end - start) / 1e9);

        start = System.nanoTime();
        for (long i = 0; i < ITERATIONS; ++i) {
            result = f1 / f2;
        }
        end = System.nanoTime();
        System.out.printf("Float division: Result = %f, Time = %f seconds%n", result, (end - start) / 1e9);
    }

    public static void benchmarkDoubleOperations() {
        double d1 = 1.234567890123456, d2 = 7.890123456789012;
        double result = 0.0;

        long start = System.nanoTime();
        for (long i = 0; i < ITERATIONS; ++i) {
            result = d1 * d2;
        }
        long end = System.nanoTime();
        System.out.printf("Double multiplication: Result = %f, Time = %f seconds%n", result, (end - start) / 1e9);

        start = System.nanoTime();
        for (long i = 0; i < ITERATIONS; ++i) {
            result = d1 + d2;
        }
        end = System.nanoTime();
        System.out.printf("Double addition: Result = %f, Time = %f seconds%n", result, (end - start) / 1e9);

        start = System.nanoTime();
        for (long i = 0; i < ITERATIONS; ++i) {
            result = d1 / d2;
        }
        end = System.nanoTime();
        System.out.printf("Double division: Result = %f, Time = %f seconds%n", result, (end - start) / 1e9);
    }

    public static void main(String[] args) {
        System.out.println("Benchmarking float (32-bit) operations:");
        benchmarkFloatOperations();
        System.out.println("\nBenchmarking double (64-bit) operations:");
        benchmarkDoubleOperations();
    }
}

/**
    Benchmarking float (32-bit) operations:
    Float multiplication: Result = 9.740886, Time = 0.027326 seconds
    Float addition: Result = 9.124690, Time = 0.027863 seconds
    Float division: Result = 0.156470, Time = 0.024781 seconds

    Benchmarking double (64-bit) operations:
    Double multiplication: Result = 9.740893, Time = 0.026711 seconds
    Double addition: Result = 9.124691, Time = 0.026726 seconds
    Double division: Result = 0.156470, Time = 0.027096 seconds
 */
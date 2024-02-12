public class Matrix {
    private static final int N = 500; 

    public static void main(String[] args) {
        double[][] a = new double[N][N]; 
        double[][] b = new double[N][N];
        double[][] result = new double[N][N];

        multiply(a, b, result);
    }

    public static void multiply(double[][] a, double[][] b, double[][] result) {
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                result[i][j] = 0;
                for (int k = 0; k < N; k++) {
                    result[i][j] += a[i][k] * b[k][j];
                }
            }
        }
    }
}

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Matrix {
    private static final int N = 500; 

    public static void main(String[] args) {
        double[][] matrix = new double[500][500];
        String filePath = "../../tests/matrix/matrix_Java.txt";
        int index = 0;

        final int ROWS = 500;
        final int COLS = 500;

        try {
            BufferedReader reader = new BufferedReader(new FileReader(filePath));
            String line;
            int row = 0;
            while ((line = reader.readLine()) != null && row < 500) {
                String[] values = line.split(",\\s*"); 
                for (int col = 0; col < values.length && col < 500; col++) {
                    matrix[row][col] = Float.parseFloat(values[col]); 
                }
                row++;
            }
            reader.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        double[][] result = new double[N][N];
        multiply(matrix, matrix, result);
        print(result);
    }

    public static void multiply(double[][] a, double[][] b, double[][] result) 
    {
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                result[i][j] = 0;
                for (int k = 0; k < N; k++) {
                    result[i][j] += a[i][k] * b[k][j];
                }
            }
        }
    }

    public static void print(double[][] matrix) 
    {
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.printf("%.2f ", matrix[i][j]);
            }
            System.out.println(); 
        }
    }

}

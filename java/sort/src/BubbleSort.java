import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class BubbleSort {
    
    
    public static void main(String[] args) {
        String filePath = "../../tests/arrays/tab.txt";
        int[] arr = new int[100000];
        int index = 0;


        try {
            File file = new File(filePath);
            Scanner scanner = new Scanner(file).useDelimiter(",\\s*");
            
            while (scanner.hasNextInt() && index < arr.length) {
                arr[index++] = scanner.nextInt();
            }
            scanner.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        bubbleSort(arr);
    }

    static void bubbleSort(int[] arr) {
        int n = arr.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (arr[j] > arr[j + 1]) {
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
    }

    static void printArray(int[] arr) {
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println();
    }
}

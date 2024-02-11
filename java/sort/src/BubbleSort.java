import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class BubbleSort {
    
    
    public static void main(String[] args) {
        String filePath = "../../tests/arrays/tab.txt";
        int[] arr = new int[100000]; // Création d'un tableau pour stocker 100 000 entiers
        int index = 0;


        try {
            File file = new File(filePath);
            // Utilisez le Scanner avec un délimiteur qui reconnaît les virgules et les espaces blancs
            Scanner scanner = new Scanner(file).useDelimiter(",\\s*");
            
            while (scanner.hasNextInt() && index < arr.length) {
                arr[index++] = scanner.nextInt();
            }
            scanner.close();

            // Affiche le nombre d'entiers lus pour vérification
            System.out.println("Nombre d'entiers lus : " + index);
        } catch (FileNotFoundException e) {
            System.err.println("Le fichier n'a pas été trouvé.");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Une erreur est survenue lors de la lecture du fichier.");
            e.printStackTrace();
        }

        bubbleSort(arr);
        //System.out.println("Sorted array:");
        //printArray(arr);
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

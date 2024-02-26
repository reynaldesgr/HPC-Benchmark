import argparse
import gzip

def compress_measure_size(file_path):
    """Compresse le fichier spécifié et retourne la taille du fichier compressé."""
    with open(file_path, 'rt', encoding='utf-8') as file:
        data = file.read()
        compressed_data = gzip.compress(bytes(data, 'utf-8'))
        return len(compressed_data)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Mesure la taille compressée du fichier source.')
    parser.add_argument('file_path', type=str, help='Chemin du fichier source à compresser.')

    args = parser.parse_args()

    size = compress_measure_size(args.file_path)
    print(f"Compressed source code size: {size} bytes")

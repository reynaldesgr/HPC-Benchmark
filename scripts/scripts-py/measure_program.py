import argparse
import subprocess
import os
import sys
import time
from time_memory_measurement import measure_time_memory
import signal
import psutil

def run_program(program_path, input_value, output_path="/dev/null", timeout=3600):
    """Executes the program with a specific input value and redirects the output."""
    with open(output_path, "w") as output_file:
        start = time.time()
        process = subprocess.Popen([sys.executable, program_path, str(input_value)], stdout=output_file, stderr=subprocess.STDOUT)
        try:
            pid, status, resource_usage = os.wait3(os.WNOHANG)
            process.wait(timeout=timeout)
            end = time.time()
        except subprocess.TimeoutExpired:
            process.kill()
            print(f"Timeout expired for input {input_value}. Program was killed after {timeout} seconds.")
            return None
        cpu_time = resource_usage.ru_utime + resource_usage.ru_stime
        memory_usage = resource_usage.ru_maxrss
    return {
        "time_taken": end - start,
        "cpu_time": cpu_time,
        "memory_usage": memory_usage
    }

def check_output(expected_output_path, output_path="program_output.txt"):
    """Checks if the program output matches the expected output."""
    with open(expected_output_path, "r") as expected, open(output_path, "r") as output:
        return expected.read().strip() == output.read().strip()

def main(program_path, expected_output_path, input_values):
    """Executes the program for a set of input values and measures performance."""
    for input_value in input_values:
        output_path = "temp_output.txt"  # Temporary for verification
        result = run_program(program_path, input_value, output_path, timeout=120)  # Short timeout for the first run
        
        if result and check_output(expected_output_path, output_path):
            print(f"Input: {input_value}, Time: {result['time_taken']:.2f} sec, CPU Time: {result['cpu_time']:.2f} sec, Memory: {result['memory_usage']} KB")
            for _ in range(5):  # Repeat runs for accurate measurement
                run_program(program_path, input_value, "/dev/null", timeout=120)
        else:
            print(f"Program did not produce expected output for input {input_value} or timed out.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run a program with different inputs and check its output and performance.")
    parser.add_argument('program_path', type=str, help="Path to the program to be executed.")
    parser.add_argument('expected_output_path', type=str, help="Path to the file containing the expected output.")
    parser.add_argument('--input_values', type=int, nargs='+', required=True, help="A series of input values to be passed to the program.")

    args = parser.parse_args()

    main(args.program_path, args.expected_output_path, args.input_values)

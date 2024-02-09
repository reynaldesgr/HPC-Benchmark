import argparse
import subprocess
import time
import psutil

def run_program(program_path, output_path="program_output.txt", timeout=3600):
    """Executes the program and redirects the output to a file while monitoring CPU time and memory usage."""
    with open(output_path, "w") as output_file:
        start = time.time()
        cpu_time = 0
        max_memory_usage = 0
        process = subprocess.Popen([program_path], stdout=output_file, stderr=subprocess.STDOUT)
        ps_process = psutil.Process(process.pid)  # Wrap subprocess with psutil to monitor

        try:
            # Check process status in intervals to allow for real-time updates
            while process.poll() is None:  # Check if process has terminated
                time.sleep(1)  # Interval of 1 second to prevent high CPU load due to monitoring
                cpu_time = ps_process.cpu_times().user + ps_process.cpu_times().system
                current_memory_usage = ps_process.memory_info().rss / 1024  # Convert to KB
                if current_memory_usage > max_memory_usage:
                    max_memory_usage = current_memory_usage

                if time.time() - start > timeout:  # Check for timeout
                    ps_process.kill()
                    raise subprocess.TimeoutExpired(program_path, timeout)

            end = time.time()
        except subprocess.TimeoutExpired:
            print(f"Timeout expired. Program was killed after {timeout} seconds.")
            return None

        return {
            "time_taken": end - start,
            "cpu_time": cpu_time,
            "memory_usage": max_memory_usage  # Return the peak memory usage
        }

def main(program_path):
    """Executes the program and measures performance."""
    output_path = "output.txt"  # Output file name
    result = run_program(program_path, output_path, timeout=120)  # Short timeout for the run

    if result:
        print(f"Output generated in {output_path}.")
        print(f"Time: {result['time_taken']:.2f} sec, CPU Time: {result['cpu_time']:.2f} sec, Memory: {result['memory_usage']} KB")
    else:
        print("Program did not complete successfully or timed out.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run a program and check its performance.")
    parser.add_argument('program_path', type=str, help="Path to the program to be executed.")

    args = parser.parse_args()

    main(args.program_path)

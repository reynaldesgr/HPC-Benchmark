import argparse
import subprocess
import time
import psutil

def run_program(command, output_path="program_output.txt", timeout=3600):
    """Executes the command and redirects the output to a file while monitoring CPU time and memory usage."""
    with open(output_path, "w") as output_file:
        start = time.time()
        cpu_time = 0
        max_memory_usage = 0
        # Execute the command passed as a list to subprocess.Popen
        process = subprocess.Popen(command, stdout=output_file, stderr=subprocess.STDOUT, shell=True)
        ps_process = psutil.Process(process.pid)  # Wrap subprocess with psutil to monitor

        try:
            while process.poll() is None:
                time.sleep(1)
                cpu_time = ps_process.cpu_times().user + ps_process.cpu_times().system
                current_memory_usage = ps_process.memory_info().rss / 1024  # Convert to KB
                if current_memory_usage > max_memory_usage:
                    max_memory_usage = current_memory_usage

                if time.time() - start > timeout:
                    ps_process.kill()
                    raise subprocess.TimeoutExpired(" ".join(command), timeout)

            end = time.time()
        except subprocess.TimeoutExpired:
            print(f"Timeout expired. Program was killed after {timeout} seconds.")
            return None

        return {
            "time_taken": end - start,
            "cpu_time": cpu_time,
            "memory_usage": max_memory_usage
        }

def main(command):
    """Executes the command and measures performance."""
    output_path = "output.txt"
    result = run_program(command, output_path, timeout=120)

    if result:
        print(f"Output generated in {output_path}.")
        print(f"Time: {result['time_taken']:.2f} sec, CPU Time: {result['cpu_time']:.2f} sec, Memory: {result['memory_usage']} KB")
    else:
        print("Program did not complete successfully or timed out.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run a command and check its performance.")
    # Modification here to accept a complete command
    parser.add_argument('command', type=str, nargs='+', help="Command to be executed.")
    
    args = parser.parse_args()
    
    # Passing the command as a list to the main function
    main(args.command)

import subprocess
import os
import sys
import time
import resource

def get_process_times():
    usage = resource.getrusage(resource.RUSAGE_CHILDREN)
    return usage.ru_utime, usage.ru_stime

def compile_and_run(source, args, optimizations, executions, output_dir, output_file):
    basename = os.path.splitext(os.path.basename(source))[0]
    output_path = os.path.join(output_dir, output_file)

    # Assurez-vous que le répertoire de sortie existe
    os.makedirs(output_dir, exist_ok=True)

    with open(output_path, 'w') as f:
        f.write("Optimization,Real Time(s),User Time(s),System Time(s),Binary Size(bytes)\n")

    for opt in optimizations:
        bin_name = f"{basename}_opt{opt}"
        compile_cmd = f"rustc -C opt-level={opt} {source} -o {bin_name}"

        print(f"Compiling {source} with optimization level {opt}...")
        compile_result = subprocess.run(compile_cmd, shell=True)

        if compile_result.returncode == 0:
            binary_size = os.path.getsize(bin_name)

            for i in range(executions):
                start_time = time.time()
                run_cmd = f"./{bin_name} {' '.join(args)}"
                subprocess.run(run_cmd, shell=True)
                end_time = time.time()

                user_time, sys_time = get_process_times()
                real_time = end_time - start_time

                print(f"Running {bin_name} with arguments {' '.join(args)}... (Attempt {i+1}) - Real Time: {real_time}s")

                with open(output_path, 'a') as f:
                    f.write(f"{opt},{real_time},{user_time},{sys_time},{binary_size}\n")
        else:
            print(f"Compilation failed for optimization level {opt}")
            with open(output_path, 'a') as f:
                f.write(f"{opt},Compilation Failed\n")

        os.remove(bin_name)

    print(f"Benchmark results have been saved to {output_path}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 script.py <source_file.rs> [args for executable...]")
        sys.exit(1)

    source_file = sys.argv[1]
    additional_args = sys.argv[2:]
    optimizations = ["0", "1", "2", "3", "s", "z"]
    executions = 10
    output_dir = "../../results"
    output_file = f"{os.path.splitext(os.path.basename(source_file))[0]}_compilation_stats-rust.csv"

    compile_and_run(source_file, additional_args, optimizations, executions, output_dir, output_file)

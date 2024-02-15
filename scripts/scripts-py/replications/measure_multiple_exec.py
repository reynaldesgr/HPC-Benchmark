import subprocess
import os
import sys
from time import time

def is_integer(s):
    try:
        int(s)
        return True
    except ValueError:
        return False
    
if len(sys.argv) < 2:
    print("Usage: script.py <language> path-to-source-file [additional_args NUMBER]")
    sys.exit(1)

language    = sys.argv[1].lower()
source_file = sys.argv[2]

if (len(sys.argv) > 2):
    executable_args = [arg for arg in sys.argv[3:] if is_integer(arg)]

output_dir          = os.path.dirname(os.path.abspath(source_file))
output_file_path    = os.path.join(output_dir, "execution_results.csv")
source_dir          = os.path.dirname(os.path.abspath(source_file))
root_dir            = os.path.dirname(source_dir)
bin_dir             = os.path.join(root_dir, "bin")

executable_name     = os.path.splitext(os.path.basename(source_file))[0]

def compile_source(language, source_file, executable_name):
    compile_commands = {
        "rust": f"rustc {source_file} -o {executable_name}",
        "java": f"javac -d {bin_dir} -sourcepath {source_dir} {source_file}",
        "fortran": f"gfortran {source_file} -o {executable_name}",
        "c": f"gcc {source_file} -o {executable_name}", 
        "erlang": f"erlc {source_file}",
        "cpp": f"g++ {source_file} -o {executable_name}",
    }
    if language in compile_commands:
        print("[Compilation] - Compiling...")
        compilation_result = subprocess.run(compile_commands[language], shell=True, capture_output=True)
        if compilation_result.returncode != 0:
            print("Compilation error:", compilation_result.stderr.decode())
            sys.exit(1)
        print("[Compilation] - Success")

def execute_and_measure(executable_name, args, language):
    command = []

    if language == "java":
        class_name = os.path.splitext(os.path.basename(source_file))[0]
        command = ["/usr/bin/time", "-f", "%U %S %e", "java", "-cp", bin_dir, class_name]
    elif language in ["ruby", "python"]:
        command = ["/usr/bin/time", "-f", "%U %S %e", language, source_file]
    elif language == "erlang" and len(args) > 0:
        erl_command = f'erl -noshell -run {executable_name} main'
        command_str = f'/usr/bin/time -f "%U %S %e" {erl_command}'
        if args:
            command_str += ' ' + ' '.join(args)
        result = subprocess.run(command_str, capture_output=True, text=True, shell=True)
    elif language == "erlang" and len(args) == 0:
        erl_command = f'erl -noshell -s {executable_name} main -s init stop'
        command_str = f'/usr/bin/time -f "%U %S %e" {erl_command}'
        if args:
            command_str += ' ' + ' '.join(args)
        result = subprocess.run(command_str, capture_output=True, text=True, shell=True)
    else:
        command = ["/usr/bin/time", "-f", "%U %S %e", "./" + executable_name]

    if language != "erlang":
        result = subprocess.run(command, capture_output=True, text=True, shell=False)
    
    if result.returncode != 0:
        print("Execution error:", result.stderr)
        return None

    timings = result.stderr.strip().split() if language not in ["python", "ruby", "erlang"] else result.stdout.strip().split()
    user_time, sys_time, real_time = timings[0], timings[1], timings[2]

    return {
        "user": user_time,
        "sys": sys_time,
        "real": real_time
    }

if language not in ["python", "ruby"]:
    compile_source(language, source_file, executable_name)

print("[Measures]")
with open(output_file_path, "w") as output_file:
    if language not in ["python", "ruby", "java"]:
        output_file.write("User Time (s), System Time (s), Real Time (s), Executable Size (KB)\n")
    else:
        output_file.write("User Time (s), System Time (s), Real Time (s)\n")

    for i in range(30):
        print(f"[{i+1}] - Running...")
        result = execute_and_measure(executable_name, executable_args, language)
        if result and language not in ["python", "ruby",  "java"]:
            if language == "erlang":
                executable_size_kb = os.path.getsize(executable_name + ".beam") / 1024
            else:
                executable_size_kb = os.path.getsize(executable_name) / 1024
                
            output_file.write(f"{result['user']}, {result['sys']}, {result['real']}, {executable_size_kb:.2f} \n")
        else:
            output_file.write(f"{result['user']}, {result['sys']}, {result['real']}\n")

print(f"> Execution results have been written to {output_file_path}")
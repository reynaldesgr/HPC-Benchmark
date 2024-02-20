import psutil
import time
import sys
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

def monitor_cpu_usage(pids, ax):
    start_time = time.time()
    data = {pid: {'times': [], 'cpu_usages': []} for pid in pids}

    def update(frame):
        current_time = time.time() - start_time
        ax.clear()
        for pid in pids:
            try:
                proc = psutil.Process(pid)
                cpu_usage = proc.cpu_percent(interval=0.1)
                data[pid]['times'].append(current_time)
                data[pid]['cpu_usages'].append(cpu_usage)

                ax.plot(data[pid]['times'], data[pid]['cpu_usages'], label=f'PID {pid}')

            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                print(f"Process with PID {pid} no longer exists or access denied.")
                continue 
        
        ax.set_title('CPU usage')
        ax.set_xlabel('Time (s)')
        ax.set_ylabel('CPU usage (%)')
        ax.legend()

        if len(data[pids[0]]['times']) > 10:
            ax.set_xlim(left=max(0, current_time-10), right=current_time+1)

    return update

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <PID1> <PID2> ...")
        sys.exit(1)
    pids = [int(pid) for pid in sys.argv[1:]] 

    fig, ax = plt.subplots()
    ani = FuncAnimation(fig, monitor_cpu_usage(pids, ax), interval=1000)
    plt.show()
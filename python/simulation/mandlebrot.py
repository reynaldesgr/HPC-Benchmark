import numpy as np

def mandelbrot(cr, ci, max_iter):
    zr, zi = 0.0, 0.0
    for n in range(max_iter):
        zr2, zi2 = zr*zr, zi*zi
        if zr2 + zi2 > 4.0:
            return n
        zi = 2.0 * zr * zi + ci
        zr = zr2 - zi2 + cr
    return max_iter

size = 800
max_iter = 16000
data = np.zeros((size, size), dtype=int)

for y in range(size):
    for x in range(size):
        cr = 4.0 * x / size - 2.0
        ci = 4.0 * y / size - 2.0
        data[y, x] = mandelbrot(cr, ci, max_iter)
        
np.savetxt('mandelbrot_python.csv', data, delimiter=',', fmt='%d')

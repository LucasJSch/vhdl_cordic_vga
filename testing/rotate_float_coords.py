import csv
import io
import math
import random
from scipy.spatial.transform import Rotation as R
import numpy as np

BASE_PATH = "/home/ljsch/FIUBA/SisDig/repo_TP_final/vhdl_cordic_vga/testing/"
OUTPUT_FILE_PATH = BASE_PATH + "float_coordenadas_test.txt"
output = io.StringIO()
output.write("alpha,beta,gamma,x_i,y_i,z_i,x_o,y_o,z_o\n")

def transform(gamma, beta, alpha, vector):
    r_z = R.from_euler('z', gamma, degrees=True)
    r_y = R.from_euler('y', beta, degrees=True)
    r_x = R.from_euler('x', alpha, degrees=True)
    return r_z.apply(r_y.apply(r_x.apply(vector)))

def round_vector(x,y,z):
    return round(x), round(y), round(z)


N_BITS_VECTOR = 15
N_samples = 1000
ONE_REP = 2 ** (N_BITS_VECTOR-1)

for _ in range(N_samples):
    # Degrees
    alpha = round((random.uniform(-1, 1)) * 90)
    beta =  round((random.uniform(-1, 1)) * 90)
    gamma = round((random.uniform(-1, 1)) * 90)
    x = round((random.uniform(0, 1)) * ONE_REP)
    y = round((random.uniform(0, 1)) * ONE_REP)
    z = round((random.uniform(0, 1)) * ONE_REP)
    x_o,y_o,z_o = transform(gamma, beta, alpha, [x,y,z])
    x_o,y_o,z_o = round_vector(x_o,y_o,z_o)

    aux = str(alpha) + "," + str(beta) + "," + str(gamma) + "," + str(x) + "," + str(y) + "," + str(z) + "," + str(x_o) + "," + str(y_o) + "," + str(z_o) + "\n"
    output.write(aux)

with open(OUTPUT_FILE_PATH, mode='w') as f_output:
    print(output.getvalue(), file=f_output)

import csv
import io
import math
import random

BASE_PATH = "/home/ljsch/FIUBA/SisDig/repo_TP_final/vhdl_cordic_vga/testing/"
INPUT_FILE_PATH = BASE_PATH + "float_coordenadas.txt"
OUTPUT_FILE_PATH = BASE_PATH + "float_coordenadas_test.txt"
output = io.StringIO()
output.write("alpha,beta,gamma,x_i,y_i,z_i,x_o,y_o,z_o")

def x_rotation(angle, x, y, z):
    y = math.cos(angle)*y - math.sin(angle)*z
    z = math.sin(angle)*y + math.cos(angle)*z
    return [x,y,z]

def y_rotation(angle, x, y, z):
    x = math.cos(angle)*x + math.sin(angle)*z
    z = -math.sin(angle)*x + math.cos(angle)*z
    return [x,y,z]

def z_rotation(angle, x, y, z):
    x = math.cos(angle)*x - math.sin(angle)*y
    y = math.sin(angle)*x + math.cos(angle)*y
    return [x,y,z]

def angle_to_binary(angle):
    pi_rep_in_vhd = 2**8
    # Get binary representation in string, without the '0b' initial chars
    #return bin(round(pi_rep_in_vhd * angle / math.pi))[2:]
    return round(pi_rep_in_vhd * angle / math.pi)

with open(INPUT_FILE_PATH, newline='') as f_input:
    reader = csv.reader(f_input, delimiter=',')
    for row in reader:
        # Radians
        alpha = (random.uniform(0, 1)) * math.pi
        beta =  (random.uniform(0, 1)) * math.pi
        gamma = (random.uniform(0, 1)) * math.pi
        x_o = x = int(row[0])
        y_o = y = int(row[1])
        z_o = z = int(row[2])
        x_o,y_o,z_o = z_rotation(gamma, x_o,y_o,z_o)
        x_o,y_o,z_o = y_rotation(beta,  x_o,y_o,z_o)
        x_o,y_o,z_o = x_rotation(alpha, x_o,y_o,z_o)

        aux = str(angle_to_binary(alpha)) + "," + str(angle_to_binary(beta)) + "," + str(angle_to_binary(gamma)) + "," + str(x) + "," + str(y) + "," + str(z) + "," + str(round(x_o)) + "," + str(round(y_o)) + "," + str(round(z_o)) + "\n"
        output.write(aux)

with open(OUTPUT_FILE_PATH, mode='w') as f_output:
    print(output.getvalue(), file=f_output)

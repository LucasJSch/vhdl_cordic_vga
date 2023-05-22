import csv
import io

BASE_PATH = "/home/ljsch/FIUBA/SisDig/repo_TP_final/vhdl_cordic_vga/testing/"
INPUT_FILE_PATH = BASE_PATH + "coordenadas.txt"
OUTPUT_FILE_PATH = BASE_PATH + "float_coordenadas.txt"
ONE_REP = 2**16
output = io.StringIO()

with open(INPUT_FILE_PATH, newline='') as f_input:
    reader = csv.reader(f_input, delimiter=',')
    for row in reader:
        x = int(float(row[0]) * ONE_REP)
        y = int(float(row[1]) * ONE_REP)
        z = int(float(row[2]) * ONE_REP)
        aux = str(x) + "," + str(y) + "," + str(z) + "\n"
        output.write(aux)

with open(OUTPUT_FILE_PATH, mode='w') as f_output:
    print(output.getvalue(), file=f_output)

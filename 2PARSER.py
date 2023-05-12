
# Diccionario
instrucciones = {
    "add": ("100000", "00000", "", "", "", "000000"),
}

arch = open('./txt.txt', 'r')
out = open('3.txt', 'w')

# Recorrer el archivo de entrada y escribir el código binario de cada instrucción tipo R en el archivo de salida
for linea in arch:
    campos = linea.strip().split(",")
    instruction = campos[0]
    codigo = ""

    if instruction in instrucciones:
        codigo += instrucciones[instruction][0]
        codigo += instrucciones[instruction][1]
        codigo += bin(int(campos[3][1:].replace("$", "")))[2:].zfill(5)  # rd
        codigo += bin(int(campos[2][1:].replace("$", "")))[2:].zfill(5)  # rt
        codigo += bin(int(campos[1][1:].replace("$", "")))[2:].zfill(5)  # rs
        codigo += instrucciones[instruction][2]
        codigo += instrucciones[instruction][3]
        codigo += instrucciones[instruction][4]
        codigo += instrucciones[instruction][5]

    out.write(codigo + '\n')


# Cerrar los archivos de entrada y salida
arch.close()
out.close()

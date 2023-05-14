 # Diccionario
instrucciones = {
    "add": ("100000", "00000", "", "", "", "000000"),
    "sub": ("100010", "00000", "", "", "", "000000"),
    "slt": ("101010", "00000", "", "", "", "000000"),
    #Type I
    "addi": ("001000", "", "", "", "", ""),
    "beq": ("000100", "", "", "", "", ""),
    "sw": ("101011", "", "", "", "", ""),
    "lw": ("100011", "", "", "", "", ""),
    "j": ("000010", "", "", "", "", "")
}


arch = open('./in.txt', 'r')
out = open('out.txt', 'w')

# Recorrer el archivo de entrada y escribir el código binario de cada instrucción tipo R en el archivo de salida
for linea in arch:
    campos = linea.strip().split(",")
    instruction = campos[0]
    codigo = ""

    if instruction in instrucciones:
        if instruction == "add" or instruction == "sub" or instruction == "slt":
            codigo += instrucciones[instruction][0]
            codigo += instrucciones[instruction][1]
            codigo += bin(int(campos[3][1:].replace("$", "")))[2:].zfill(5)  # rd
            codigo += bin(int(campos[2][1:].replace("$", "")))[2:].zfill(5)  # rt
            codigo += bin(int(campos[1][1:].replace("$", "")))[2:].zfill(5)  # rs
        
        if instruction == "addi" or instruction == "beq" or instruction == "lw" or instruction == "sw":
            codigo += instrucciones[instruction][0]
            #codigo += bin(int(campos[3][1:].replace("$", "")))[2:].zfill(5)  # rd
            codigo += bin(int(campos[2][1:].replace("$", "")))[2:].zfill(5)  # rt
            codigo += bin(int(campos[1][1:].replace("$", "")))[2:].zfill(5)  # rs
            codigo += bin(int(campos[3].replace("#", "")))[2:].rjust(16, "0")  # inmediato
        if instruction == "j":
            # Si es una instrucción tipo J se convierte el valor inmediato a binario y se quitan los dos primeros caracteres
            codigo += instrucciones[instruction][0]
            codigo += bin(int(campos[1]))[2:].zfill(26)
        
        codigo += instrucciones[instruction][2]
        codigo += instrucciones[instruction][3]
        codigo += instrucciones[instruction][4]
        codigo += instrucciones[instruction][5]


    out.write(codigo + '\n')


# Cerrar los archivos de entrada y salida
arch.close()
out.close()
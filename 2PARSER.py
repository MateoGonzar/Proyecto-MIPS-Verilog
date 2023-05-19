 # Diccionario
instrucciones = {
    #Type r
    "add": ("000000", "00000", "", "", "", "000000"),
    "sub": ("000000", "00000", "", "", "", "000000"),
    "slt": ("000000", "00000", "", "", "", "000000"),
    #Type I
    "addi": ("001001", "", "", "", "", ""),
    "beq": ("010100", "", "", "", "", ""),
    "sw": ("101011", "", "", "", "", ""),
    "lw": ("100011", "", "", "", "", ""),
    #Type J
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
        
        if instruction == "addi" or instruction == "beq" or instruction == "sw" or instruction == "lw":
            codigo += instrucciones[instruction][0]
            codigo += bin(int(campos[2][1:].replace("$", "")))[2:].zfill(5)  # rt
            codigo += bin(int(campos[1][1:].replace("$", "")))[2:].zfill(5)  # rs
            codigo += bin(int(campos[3].replace("#", "")))[2:].rjust(16, "0")  # inmediato
     
        if instruction == "j" :
            codigo += instrucciones[instruction][0]
            number = int(campos[1][1:])  # Extract the numeric part of the instruction, excluding the '#'
            codigo += bin(number)[2:].zfill(26)  # Convert the number to binary and pad it to 26 bits
            
        if instruction == "jal":
            codigo += instrucciones[instruction][0]
            number = int(campos[1][1:])  # Extract the numeric part of the instruction, excluding the '#'
            codigo += bin(number)[2:].zfill(26)  # Convert the number to binary and pad it to 26 bits

        codigo += instrucciones[instruction][2]
        codigo += instrucciones[instruction][3]
        codigo += instrucciones[instruction][4]
        codigo += instrucciones[instruction][5]
        
        # Slice the output in 8 bit long lines and append the rest in new lines
        for i in range(0, len(codigo), 8):
            out.write(codigo[i:i+8] + '\n')
        #out.write(codigo + '\n')

# Cerrar los archivos de entrada y salida
arch.close()
out.close()
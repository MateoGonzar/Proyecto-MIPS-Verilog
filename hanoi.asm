.data                   
.text
.globl main
main:
    # valores de parametros para hanoi
    addi $a0, $zero, 3 # numero de discos
    addi $a1, $zero, 'A'
    addi $a2, $zero, 'B'
    addi $a3, $zero, 'C'

    j hanoi           # salto o llamada a hanoi

hanoi:                  # subrutina hanoi

    addi $sp, $sp, -20  # asignacion de espacio en el stack (stack pointer)
    sw   $ra, 0($sp)
    sw   $s0, 4($sp)
    sw   $s1, 8($sp)
    sw   $s2, 12($sp)
    sw   $s3, 16($sp)   # se guardan los registros ra, s0, s1, s2, s3 en el stack

    add $s0, $a0, $zero
    add $s1, $a1, $zero
    add $s2, $a2, $zero
    add $s3, $a3, $zero # se asignan los parametros de a0-a3 a los registros s0-s3
    addi $t1, $zero, 1  # t1 = 1
    slt $t7, $zero, $t1   
    beq $s0, $t7, output # si solo hay un disco (s0 == 1) se salta a output (branch if equal)

    recur1:       # disco más largo no está en la primera vara (n-1, origen, auxiliar, destino)
        
        sub $a0, $s0, $t7   # disminuir el valor de s0 en 1 y asignarlo a a0
        add $a1, $s1, $zero
        add $a2, $s3, $zero
        add $a3, $s2, $zero # copia de parametros para la llamada recursiva
        jal hanoi           # llama a hanoi con parametros actualizados

        j output           # salto directo a output

    recur2:       # disco más largo sí está en la primera vara (n-1, destino, origen, auxiliar)

        sub $a0, $s0, $t7
        add $a1, $s3, $zero
        add $a2, $s2, $zero
        add $a3, $s1, $zero
        jal hanoi

    exithanoi:                  # rutina de salida

        lw   $ra, 0($sp)        # restaurar registros del stack
        lw   $s0, 4($sp)
        lw   $s1, 8($sp)
        lw   $s2, 12($sp)
        lw   $s3, 16($sp)

        addi $sp, $sp, 20       # restaurar stack pointer (sp) para liberar espacio
        
        jr $ra  # inmediatamente regresa a la dirección de retorno (ra) para dar por terminada la subrutina
    output:

        beq $s0, $t7, exithanoi # si solo hay un disco (s0 == 1) se salta a exithanoi
        j recur2                # de lo contrario, salto directo a recur2
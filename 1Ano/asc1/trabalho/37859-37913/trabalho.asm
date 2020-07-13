.data 
FILE: .asciiz "/home/diogoraf8/lena.rgb" #ficheiro a converter
BufferRGB: .space 786432 #buffer de 512x512x3
BufferGRAY: .space 262144 #buffer de 512 x 512
FILE_gray: .asciiz "/home/diogoraf8/lena1.gray" #ficheiro convertido
Error: .asciiz "\nErro\n" #print no caso de erro
.text

#saltar para cada uma das funcoes
main:
jal readRGB 
nop
jal Conversion
nop
jal Write
nop
j END
nop

readRGB:
#abrir imagem
la $a0, FILE 
li $a1, 0
li $a2, 0
li $v0, 13
syscall

#apresentar mensagem de erro caso $vo seja -1
beq $v0,-1,ERROR
nop

move $s0,$v0 

#ler imagem
move $a0, $v0
la $a1, BufferRGB
la $a2, 786432
li $v0, 14
syscall
	
jr $ra
nop
	
Conversion:

addi $sp, $sp, -4
sw $ra, 0($sp)

#carregar as posicoes iniciais dos buffers
la $t0,BufferRGB
la $t5,BufferGRAY

add $t6,$t0,786432

LOOP:
lbu $t1,0($t0)
lbu $t2,1($t0)
lbu $t3,2($t0)
#ir buscar os bytes da imagem com cor
mul $t1, $t1, 30
div $t1, $t1, 100
mul $t2, $t2, 59
div $t2, $t2, 100
mul $t3, $t3, 11
div $t3, $t3, 100
#0.3 * vermelho, 0.59 * verde, 0.11 * azul sem resto de divisao
add $t4,$t1,$t2
add $t4,$t4,$t3
#somar os valores
sb $t4,0($t5)
#colocar equivalente dos tres valores num bite do gray
add $t0,$t0,3
add $t5,$t5,1
bne $t0,$t6,LOOP
nop

lw $ra, 0($sp)
addi $sp, $sp, 4

jr $ra
nop	

Write: #ler e escrever os bytes do buffer no ficheiro .gray
la $a0,FILE_gray
li $a1,1
li $a2,0
li $v0,13
syscall

beq $v0,-1,ERROR
nop

move $s1,$v0 

move $a0,$v0
la $a1,BufferGRAY
li $a2, 262144
li $v0,15
syscall



jr $ra
nop

ERROR: #em caso de erro, apresenta a mensagem "Erro"
la $a0,Error
li $v0,4
syscall
j END
nop

END: #fecha e conclui ttodos os ficheiros
move $a0, $s0
li $v0,16
syscall

move $a0, $s1
li $v0,16
syscall

nop

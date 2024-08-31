#Chuong trinh: BTL

#Data segment
	.data
#Cac dinh nghia bien
int_part_1: .word  13
int_part_2: .word  14
int_part_3: .word  15

frac_part_1: .word 16
frac_part_2: .word 17
frac_part_3: .word 18

temp:        .word  0
tenfile:	.asciiz	"D:\\SOLE.TXT"
fdescr:		.word	0
dot: .asciiz "."
end_line: .asciiz "\n"
hai_so_le: .asciiz "So f1 (2 so le): "
ba_so_le: .asciiz "So f2 (3 so le): "
bon_so_le: .asciiz "So f3 (4 so le): "
#Cac cau nhac nhap du lieu
str_tc:		.asciiz	"Thanh cong."
str_loi:	.asciiz	"Mo file bi loi."

#Code segment
	.text
main:	
#Nhap (syscall)
#Xu ly
  #Goi ham seed
    jal seed
  #Goi ham sinh_int
    jal sinh_int
    sw $a0, int_part_1
    
    jal sinh_int
    sw $a0, int_part_2
    
    jal sinh_int
    sw $a0, int_part_3
    
  #Goi ham sinh_frac
    li $t0, 100
    jal sinh_frac
    sw $a0, frac_part_1
    
    li $t0, 1000
    jal sinh_frac  
    sw $a0, frac_part_2
    
    li $t0, 10000
    jal sinh_frac 
    sw $a0, frac_part_3

#Mo file
    la	$a0,tenfile
    addi $a1,$zero,1	# open with a1=1 (write-only)
    addi $v0,$zero,13
    syscall
#Ghi file
#t1 la phan int, t2 dung de tach tung so trong t1, t4 la so lan lap, t5 dung de align
    sw	$v0,fdescr	#luu file descriptor
    
    lw $a0, fdescr	#So f1 (2 so le): fff.ff
    la $a1, hai_so_le
    li $a2, 17
    li $v0, 15
    syscall
    
    lw  $t1, int_part_1   
    li  $t2, 100 
    li  $t4, 3
    jal loop
    
    lw   $a0,fdescr
    la   $a1, dot
    li   $a2, 1
    li   $v0, 15  
    syscall
    
    lw  $t1, frac_part_1  
    li  $t2, 10
    slt $t5, $t1, $t2
    beq $t5, 0, endif1
    mul  $t1,$t1, 10
    endif1: 
    li  $t4, 2
    jal loop
    
    lw   $a0,fdescr
    la   $a1, end_line
    li   $a2, 1
    li   $v0, 15  
    syscall
    
    lw $a0, fdescr	#So f2 (3 so le): fff.fff
    la $a1, ba_so_le
    li $a2, 17
    li $v0, 15
    syscall
    
    lw  $t1, int_part_2
    li  $t2, 100 
    jal loop
    
    lw   $a0,fdescr
    la   $a1, dot
    li   $a2, 1
    li   $v0, 15  
    syscall
    
    lw  $t1, frac_part_2  
    li  $t2, 100
    if2:
    slt $t5, $t1, $t2
    beq $t5, 0, endif2
    mul  $t1,$t1, 10
    j if2
    endif2: 
    jal loop
    
    lw   $a0,fdescr
    la   $a1, end_line
    li   $a2, 1
    li   $v0, 15  
    syscall
    
    lw $a0, fdescr	#So f3 (4 so le): fff.ffff
    la $a1, bon_so_le
    li $a2, 17
    li $v0, 15
    syscall
    
    lw  $t1, int_part_3  
    li  $t2, 100 
    jal loop
    
    lw   $a0,fdescr
    la   $a1, dot
    li   $a2, 1
    li   $v0, 15  
    syscall
    
    lw  $t1, frac_part_3  
    li  $t2, 1000
    if3:
    slt $t5, $t1, $t2
    beq $t5, 0, endif3
    mul  $t1,$t1, 10
    j if3
    endif3: 
    li  $t4, 4
    jal loop
    
    lw   $a0,fdescr
    la   $a1, end_line
    li   $a2, 1
    li   $v0, 15  
    syscall
    
#Dong file
    lw	$a0,fdescr
    addi $v0,$zero,16
    syscall
    
#Xuat ket qua tren MARS
    li $v0, 4
    la $a0, hai_so_le
    syscall
    li $v0, 1
    lw $a0, int_part_1
    syscall
    li $v0, 4
    la $a0, dot
    syscall
    li $v0, 1
    lw $a0, frac_part_1
    slti $t5, $a0, 10
    beq $t5, 0, endif11
    mul  $a0,$a0, 10
    endif11: 
    syscall
    li $v0, 4
    la $a0, end_line
    syscall
    
    li $v0, 4
    la $a0, ba_so_le
    syscall
    li $v0, 1
    lw $a0, int_part_2
    syscall
    li $v0, 4
    la $a0, dot
    syscall
    li $v0, 1
    lw $a0, frac_part_2
    if21:
    slti  $t5, $a0, 100
    beq $t5, 0, endif21
    mul  $a0,$a0, 10
    j if21
    endif21: 
    syscall
    li $v0, 4
    la $a0, end_line
    syscall
    
    li $v0, 4
    la $a0, bon_so_le
    syscall
    li $v0, 1
    lw $a0, int_part_3
    syscall
    li $v0, 4
    la $a0, dot
    syscall
    li $v0, 1
    lw $a0, frac_part_3
    if31:
    slti  $t5, $a0, 1000
    beq $t5, 0, endif31
    mul  $a0,$a0, 10
    j if31
    endif31:
    syscall
    li $v0, 4
    la $a0, end_line
    syscall
    
#Ket thuc chuong trinh (syscall)
    li $v0, 10
    syscall
#Dinh nghia function

  #Sinh so random int_part
#----------------------------------
    sinh_int:
      #Sinh so random < 1000 luu vao $a0
        li $v0, 42
        li $a1, 1000
        syscall
      #Exit
        jr $ra
#----------------------------------

  #Sinh so random frac_part
#----------------------------------
    sinh_frac:
      #Sinh so random < %t0 luu vao $a0
        li $v0, 42
        addi $a1, $t0, 0
        syscall
      #Exit
        jr $ra
#----------------------------------

  #Seed theo time function
#----------------------------------
    seed:
      #Lay time
        li $v0, 30
        syscall
        add $a1, $a0, $zero
      #Seed
        li $v0, 40
        syscall
      #Exit
        jr $ra
#----------------------------------

#Vong lap tac so va chuyen ve ascii
#----------------------------------
    loop:
        subi $t4, $t4, 1
        div  $t1, $t2
        mflo $t1	               
        mfhi $t3          
        addi $t1, $t1, 48	#doi sang ma ascii += '0'
        sw    $t1, temp
        lw   $a0,fdescr
        la   $a1, temp
        li   $a2, 1
        li   $v0, 15     
        syscall
        div  $t2, $t2, 10
        move $t1, $t3
        bnez $t4, loop   
        li  $t4, 3
        jr $ra
#----------------------------------

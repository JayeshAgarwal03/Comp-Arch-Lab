.data
msg1: .asciiz "Enter first number: "
msg2: .asciiz "Enter second number: "
msg3: .asciiz "Sum: "

.text
main:
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall
	
	add $t0, $v0, $zero
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 5
	syscall
	
	add $t1, $v0, $zero
	add $t0, $t0, $t1
	
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 1
	li $a0, 0
	add $a0, $t0, $zero
	syscall
	
	li $v0, 10
	syscall 
	
	
			
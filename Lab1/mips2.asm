.text
main:
	li $s0, 5
	li $s1, 6
	add $t0, $s0, $s1
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall 

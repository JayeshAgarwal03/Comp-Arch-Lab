# Given 3 2D points and a fixed 2D point P, return the distance of nearest point from P.
.data
	x: .float 6.0, 5.0, 4.0
	y: .float 5.0, 4.0, 3.0
	px: .float 3.0
	py: .float 4.0
	dmin: .float 10000.0
	msg: .asciiz "Distance from nearest point: \n"
	
.text
	main:
		li $t0, 0
		li $t1, 3
		li $t2, 0
		lwc1 $f0, px
		lwc1 $f1, py
		
		loop:
			beq $t0, $t1 endLoop
			lwc1 $f3, x($t2)
			lwc1 $f4, y($t2)
			sub.s $f5, $f3, $f0
			mul.s $f5, $f5, $f5
			sub.s $f6, $f4, $f1
			mul.s $f6, $f6, $f6
			add.s $f7, $f5, $f6	
			lwc1 $f8, dmin
			c.lt.s $f7, $f8 
			bc1t true
			j end_if
			
			true:
				swc1 $f7, dmin
			
			end_if:
				addi $t2, $t2, 4
				addi $t0, $t0, 1
				j loop
			
		endLoop:
			lwc1 $f10, dmin
			sqrt.s $f10, $f10
			
			li $v0, 4
			la $a0, msg
			syscall
			
			mov.s $f12, $f10
			li $v0, 2
			syscall
			
			li $v0, 10
			syscall 
			
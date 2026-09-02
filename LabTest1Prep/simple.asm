.data
	array: .float 2.0, 4.0, 2.0, 5.0, 6.0, 5.0, 2.0, 8.0, 2.0
	zero: .float 0.0
	four: .float 4.0
	two: .float 2.0
	d: .float 0.0
	negative: .float -1.0
	newLine: .asciiz "\n"
	msgEqual: .asciiz "Equal roots: "
	msgImg: .asciiz "Imaginary roots"
	msgReal: .asciiz "Real roots: "
	
.text
	main:
	
		#newton-raphson formula
		mov.s $f8, $f7        # x = n (suppose $f7 already contains n)
		lwc1 $f2, two         # f2 = 2.0
		li $t0, 0
		li $t1, 10

		loop:
    		beq $t0, $t1, done

    		div.s $f9, $f7, $f8   # n/x
    		add.s $f9, $f9, $f8   # x + n/x
    		div.s $f8, $f9, $f2   # (x + n/x)/2

    		addi $t0, $t0, 1
    		j loop

		done:
    		
    		
		#load integer
		li $v0, 5
		syscall
		move $t0, $v0
		
		#print integer
		li $v0, 1
		move $a0, $t0
		syscall
		
		#print string on terminal
		li $v0, 4
		la $a0, msg
		syscall
		
		#load float value
		li $v0, 6
		syscall
		mov.s $f1, $f0
		
		#print float value
		li $v0, 2
		mov.s $f12, $f0
		syscall
		
		#load double value
		li $v0, 7
		syscall
		mov.d $f1, $f0
		
		#print double value
		li $v0, 3
		mov.d $f12, $f0
		syscall
		
		#terminate program
		li $v0, 10
		syscall 
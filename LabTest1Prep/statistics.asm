.data
	arr: .float 2.0, 4.0, 6.0, 8.0, 10.0
	n_int: .word 5
	n_float: .float 5.0
	mean: .float 0.0
	var: .float 0.0
	
.text
	main:
		li $t0, 0
		lw $t1, n_int
		
		
		
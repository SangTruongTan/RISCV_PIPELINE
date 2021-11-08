add zero, zero, zero
addi t1, zero, 10
sw t1, 44(zero)
  	andi t0, t0, 0
  	andi t1, t0, 0
  	addi t1, t1, 1
  
  #Transmit value
	lw	t3,44(zero)
  	addi    t3, t3, -1
  # fibonnaci program
fib:
  	beq t3, zero, finish_fi
  	add t2, t1, t0
  	mv t0, t1
  	mv t1, t2
  	addi t3, t3, -1
  	j fib
finish_fi:

  	# ends the program and store value
  	sw t2,88(zero)
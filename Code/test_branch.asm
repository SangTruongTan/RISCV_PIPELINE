beq t0, t2, add
add t0, t0, t0
add: add t1,t0,t0
bgeu t0,t0,add
add t1,t0,t0
jal ra, add
jalr t0, t2, -100
add t0,t1,t2
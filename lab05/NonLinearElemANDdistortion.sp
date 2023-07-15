ELE339 Lab5 Non Linear Elements & Distrotion
* BJT Output Characteristics

.include "models/2N3904.mod"

Vcc 1  0  dc 10
Vs  5  0  dc 0 sin(0,3,10k)
rs  5  6  100k
cs  6  3  10u
co  2  7  10u
r0  7  0  1meg

rc  1  2  3.9k
re  4  0  680
ce  4  0  47u
r1  1  3  8.2k
r2  3  0  1.2k

q1 2 3 4 t2N3904
*q1 2 3 4 mod1

.tran .5u 200u
*.probe
.opt probe post=1 
.print tran v(5) v(2) v(7) 
.end


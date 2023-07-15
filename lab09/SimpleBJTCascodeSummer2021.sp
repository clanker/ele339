*Simple npn Cascode 
.include "models/2N3904.mod"

RS      8       7       300
C1      7       2       1u
R11      Vcc     2      28.13k
R12      2       0      12.03k
C2      5       0       12u
Re1      5       0      4.97k
R21	 Vcc	 22	18.13k
R22	 22	 0	22.16k
c3	 22	 0	1u
Rc2	 Vcc	 33	5k
C4      33       6       0.5u
RL      6       0       5k

Q1 3  2  5 t2N3904
Q2 33 22 3 t2N3904

*
*   Supply Voltages
*
Vcc Vcc  0  DC  15 AC 0
*
*   Input Signals

VIN 8 0   DC 0 AC 1  SIN(0 .15m 200k)

*
.option probe  POST=1
.OP 0. ALL 12.5us ALL 25us ALL 37.5us
.AC DEC 2000 1 1000MEG

*.NOISE V(6) VIN
*.probe NOISE INOISE ONOISE
.probe AC vdb(2) vdb(3) vdb(6) vp(2) vp(3) vp(6) vdb(8) vp(8) vm(8) vm(6) vdb(33)  vp(33)
.TRAN .2U 800U 
.probe tran v(2) v(3) v(22) v(33) v(6) v(7) v(8) v(5) i(Re) PAR('V(6)/v(8)') PAR('i(RL)+i(RC)')

.end

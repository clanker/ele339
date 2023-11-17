*Design Example BJT npn Follower 

.include "models/2N3904.mod"
	 
RS	8	7	50
C1	7	2	1u
R1	Vcc	2	5.21k
R2	2	0	13.26k
Re	5	0	3.63k
*R1	Vcc	2	1.29k
*R2 	2	0	3.28k
*Re	5	0	.99k
C2      5       6       0.05u
RL      6       0       300

Q1 Vcc 2 5 t2N3904

*
*   Supply Voltages
*
Vcc Vcc 0 DC 15
*
*   Input Signals

VIN 8 0   DC 0 AC 1 SIN(0 1000m 231k)

*
.option probe  POST=1
.OP 
.AC DEC 2000 .005 10000MEG
.PROBE AC vdb(8) vdb(6) vp(8) vp(6) vr(6) vi(6) v(6)
*.AC DEC 2000 10 12MEG
*.PRINT AC vdb(2) vdb(3) vp(2) vp(3) 
*.TRAN .2U 800U 
*.PRINT tran v(2) v(3) v(6) v(7) v(8)
.TRAN .2U 800U 
.probe tran v(2) v(6) v(7) v(8) 
.end

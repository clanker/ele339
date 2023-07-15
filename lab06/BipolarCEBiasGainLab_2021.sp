*ELE 339: Bipolar Transistor Biasing & AC Analysis

.include "models/2N3904.mod"

	 
RS	8	7	300
C1	7	2	1u
R1	Vcc	2	27.9K
R2	2	0	17.54K
Re	5	0	4k
Ce	5	0	.5u
*  * means comment & hspice ignores
*Re	5	51	3.95K
*Ce	5	51	.5u
*Ref	51	0	50
*  the commented section can repl. 
*  Re, Ce (5 0) for emitter degeneration
Rc 	Vcc 	3 	4k
C2      3       6       0.5u
RL      6       0       5k

Q1 3 2 5 t2N3904



*
*   Supply Voltages
*
Vcc Vcc 0 DC 15
*
*   Input Signals

VIN 8 0   DC 0 AC 1 SIN(0 3m 231k)

*
.option probe  POST=1
.OP 
.AC DEC 2000 .005 1000MEG
.PROBE AC vdb(8) vdb(6) vp(8) vp(6) vr(6) vi(6) v(6)
.TRAN .2U 80U 
.probe tran v(2) v(6) v(7) v(8) 
.end

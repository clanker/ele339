*
.include "models/D1N914.mod"
*
* Circuit with Diode
*
R2	 6	0	146.65
*R2	 6	0	145.25
C2	 6	0	8528.4571p
C1	 7	6	1u
R1	 8	7	50
D1	 7	0	d1N914
*
* Equiv Circuit with Diode Repl. by lin mod
*
R22	66	0	145.25
*R22	66	0	146.65
*C22	66	0	9226p
C22	66	0	8528.4571p
C11	77	66	1u
R11	8	77	50
Rd1	77	0	16.667
Cd1	77	0	697.5429p
*
* Thev. Equiv Circuit with Diode Repl. by lin mod
*
R222	666	0	145.25
*C222	666	0	9226p
C222	666	0	8528p
Cd2th	777	0	700p
C111	777	666	1u
Rth	88	777	12.5
*   Bias Voltages
*   	 &
*   Input Signals

V_inac 8 8a AC 1 SIN(0 50u 10k)
V_inac2 88 88a AC .25 SIN(0 50u 10k)
VIN 8a 0   DC .730
VIN2 88a 0   DC .730

.option probe  POST=1
.OP 0. ALL 12.5us ALL 25us ALL 37.5us
.TRAN .2U 800U 
.AC DEC 2000 .00001 150MEG
.probe tran V(8) V(8a) V(7) I(7) V(6)
.probe ac Vdb(7) vp(7) I(7)  Vdb(6) vp(6) I(6) Vdb(66) Vdb(666)

.end

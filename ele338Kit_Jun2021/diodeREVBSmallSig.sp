*
.include "models/D1N914.mod"

R2	 6	0	1000Meg
C1	 7	6	1u
R1	 8	7	50
D1	 0	7	d1N914
*
*   Bias Voltages
*   	 &
*   Input Signals

V_inac 8 8a AC 1u SIN(0 50u 10k)
VIN 8a 0   DC .657  

.option probe  POST=1
.OP 0. ALL 12.5us ALL 25us ALL 37.5us
.TRAN .2U 800U 
.AC DEC 2000 10 1100MEG
.probe tran V(8) V(8a) V(7) I(7) V(6)
.probe ac Vdb(7) vp(7) I(7) 

.end

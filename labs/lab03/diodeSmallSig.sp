* Lab 3 Diode Circuit

*.include "models/D1N914.mod"
.include /Users/corylanker/Documents/LTspice/ele339/models/diodes.spice.txt

R2	 6	0	1Meg
C1	 7	6	1u
C2   6  0   10n
R1	 8	7	50
D1	 7	0	1N4148
*
*   Bias Voltages
*   	 &
*   Input Signals

Vinac 8 8a SIN(0 200m 10k 0 0)
VIN 8a 0 DC .7

*.option probe  POST=1
.OP
*0. ALL 12.5us ALL 25us ALL 37.5us
.TRAN 100n 1m 0 200n
*.AC DEC 2000 .00001 50MEG

*.plot V(8,8a) V(7) V(6)
.plot tran V(8) V(8a) V(7) V(6)
*.plot ac Vdb(7) vp(7) I(7)  Vdb(6) vp(6) I(6)

.end

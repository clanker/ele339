* Early Effect and Ic vs. Vbe

* Include Model Files --------------
.include /Users/corylanker/Documents/LTspice/ele339/models/diodes.spice.txt
.include /Users/corylanker/Documents/LTspice/ele339/models/ad745.cir
.include /Users/corylanker/Documents/LTspice/ele339/models/ua741.cir

* Nodes ----------------------------

Vbe b 0 dc 0.8
Q1 c b 0 0 npn_ideal_transistor
R1 cc c 200
Vcc cc 0 dc 3

* transistor model statement
.model npn_ideal_transistor npn (Is=1.8104e-15 Bf=100 Vaf=35V)

.DC VCE 0V 10V 100mV

* unused model statements that appear by default of accessing BJT
.model NPN NPN
.model PNP PNP

* Options --------------------------
.options temp=27 

* Control --------------------------
.control
dc Vbe 0.7 0.8 0.005
print i(Vcc)
plot V(b) V(c)
.endc

.end


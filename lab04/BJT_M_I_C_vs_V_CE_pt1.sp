* ELE339 BJT Modeling IC vs. IB

.include "models/2N3904.mod"
.param piee=0 p_vce=10

* Base Current
IB    0  1  DC   10u	    		
*  Collector-emitter voltage
VCE   2   0   DC   p_vce
Rc    3	  2   2
*   BJT statement
*Tr   C	  B   E	   modelName
Q1    3   1   0    t2N3904     		

.option probe  POST=1
.OP 

.DC   VCE 0  10 .01
*.Probe dc I(VCE)
.probe dc ic=par('i(Q1)') beta=par('i(Q1)/i2(Q1)')
.END                               	

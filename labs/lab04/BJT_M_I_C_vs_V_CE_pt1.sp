* ELE339 BJT Modeling IC vs. IB

.include "/Users/corylanker/Documents/LTspice/ele339/ele338Kit_Jun2021/models/2N3904.mod"
*.param piee=0 p_vce=10

* Base Current
ib    0  1  DC   10u	    		
*  Collector-emitter voltage
vce  99   0   DC   10
vc	 99  3  dc  0
*   BJT statement
*Tr   C	  B   E	   modelName
q1    3   1   0    t2N3904     		

*2N3904
*Si 310mW  40V 200mA 300MHz pkg:TO-92B 1,2,3
.MODEL 2N3904 NPN(IS=1.4E-14 BF=300 VAF=100 IKF=0.025 ISE=3E-13
+ BR=7.5 RC=2.4 CJE=4.5E-12 TF=4E-10 CJC=3.5E-12 TR=2.1E-8 XTB=1.5 KF=9E-16 )

.control
delete all

* Transfer function analysis
*tf v(5) vin
*print all

* DC sweep analysis
dc   vce 0  10 .01
plot i(vc)

* Frequency domain analysis
*ac dec 10 1Hz 10GHz
*plot vm(5) vp(5)

* Time domain analysis
*tran 5ns 2us 0 50ns
*plot v(5)

.endc

* FROM ORIGINAL FILE
*.Probe dc I(VCE)
*.probe dc ic=par('i(Q1)') beta=par('i(Q1)/i2(Q1)')                               	

.end


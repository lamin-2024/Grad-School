* SPICE NETLIST
***************************************

.SUBCKT OAI22 GND! VDD! C D B A OUT
** N=19 EP=7 IP=0 FDC=8
M0 GND! C 7 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=144 $D=1
M1 7 D GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=144 $D=1
M2 OUT B 7 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=144 $D=1
M3 7 A OUT GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=144 $D=1
M4 9 C VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=792 $D=0
M5 OUT D 9 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=792 $D=0
M6 10 B OUT VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=792 $D=0
M7 VDD! A 10 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=792 $D=0
.ENDS
***************************************

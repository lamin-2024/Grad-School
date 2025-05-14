* SPICE NETLIST
***************************************

.SUBCKT AOI22 GND! VDD! C D B A OUT
** N=19 EP=7 IP=0 FDC=8
M0 9 C GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=144 $D=1
M1 OUT D 9 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=144 $D=1
M2 10 B OUT GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=144 $D=1
M3 GND! A 10 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=144 $D=1
M4 VDD! C 7 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=792 $D=0
M5 7 D VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=792 $D=0
M6 OUT B 7 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=792 $D=0
M7 7 A OUT VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=792 $D=0
.ENDS
***************************************

* SPICE NETLIST
***************************************

.SUBCKT XOR GND! VDD! A B OUT
** N=18 EP=5 IP=0 FDC=10
M0 5 A GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=144 $D=1
M1 GND! B 5 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=144 $D=1
M2 OUT 5 GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=144 $D=1
M3 9 B OUT GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=144 $D=1
M4 GND! A 9 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1148 $Y=144 $D=1
M5 8 A 5 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=792 $D=0
M6 VDD! B 8 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=792 $D=0
M7 6 5 VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=792 $D=0
M8 OUT B 6 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=792 $D=0
M9 6 A OUT VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1148 $Y=792 $D=0
.ENDS
***************************************

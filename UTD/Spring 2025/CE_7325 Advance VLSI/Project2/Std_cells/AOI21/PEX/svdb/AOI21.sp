* SPICE NETLIST
***************************************

.SUBCKT AOI21 GND! VDD! C B A OUT
** N=17 EP=6 IP=0 FDC=6
M0 OUT C GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=144 $D=1
M1 8 B OUT GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=144 $D=1
M2 GND! A 8 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=144 $D=1
M3 6 C VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=792 $D=0
M4 OUT B 6 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=792 $D=0
M5 6 A OUT VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=792 $D=0
.ENDS
***************************************

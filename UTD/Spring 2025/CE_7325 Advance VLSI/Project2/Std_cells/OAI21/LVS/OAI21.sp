* SPICE NETLIST
***************************************

.SUBCKT OAI21 GND! VDD! C B A OUT
** N=17 EP=6 IP=0 FDC=6
M0 6 C GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=144 $D=1
M1 OUT B 6 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=144 $D=1
M2 6 A OUT GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=144 $D=1
M3 OUT C VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=792 $D=0
M4 8 B OUT VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=792 $D=0
M5 VDD! A 8 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=792 $D=0
.ENDS
***************************************

* SPICE NETLIST
***************************************

.SUBCKT INV GND! VDD! A OUT
** N=14 EP=4 IP=0 FDC=2
M0 OUT A GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=144 $D=1
M1 OUT A VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=792 $D=0
.ENDS
***************************************

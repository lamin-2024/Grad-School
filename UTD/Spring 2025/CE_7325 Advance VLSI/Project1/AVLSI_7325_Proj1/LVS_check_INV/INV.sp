* SPICE NETLIST
***************************************

.SUBCKT INV GND! VDD! IN OUT
** N=13 EP=4 IP=0 FDC=2
M0 OUT IN GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=36 $D=1
M1 OUT IN VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=684 $D=0
.ENDS
***************************************

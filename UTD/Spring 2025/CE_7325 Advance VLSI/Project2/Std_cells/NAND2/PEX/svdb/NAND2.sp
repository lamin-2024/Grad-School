* SPICE NETLIST
***************************************

.SUBCKT NAND2 GND! VDD! A B OUT
** N=16 EP=5 IP=0 FDC=4
M0 6 A GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=144 $D=1
M1 OUT B 6 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=144 $D=1
M2 OUT A VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=792 $D=0
M3 VDD! B OUT VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=792 $D=0
.ENDS
***************************************

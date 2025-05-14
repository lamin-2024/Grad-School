* SPICE NETLIST
***************************************

.SUBCKT M_Carry GND! VDD! B A C OUT
** N=19 EP=6 IP=0 FDC=10
M0 9 B GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=144 $D=1
M1 OUT A 9 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=144 $D=1
M2 7 C OUT GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=144 $D=1
M3 GND! A 7 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=144 $D=1
M4 7 B GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1148 $Y=144 $D=1
M5 10 B VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=792 $D=0
M6 OUT A 10 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=792 $D=0
M7 8 C OUT VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=792 $D=0
M8 VDD! A 8 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=792 $D=0
M9 8 B VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1148 $Y=792 $D=0
.ENDS
***************************************

* SPICE NETLIST
***************************************

.SUBCKT MUX2_1 GND! VDD! S A B OUT
** N=22 EP=6 IP=0 FDC=12
M0 GND! S 5 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=144 $D=1
M1 9 A GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=144 $D=1
M2 7 5 9 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=144 $D=1
M3 11 S 7 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1148 $Y=144 $D=1
M4 GND! B 11 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1580 $Y=144 $D=1
M5 OUT 7 GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1796 $Y=144 $D=1
M6 VDD! S 5 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=792 $D=0
M7 10 A VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=792 $D=0
M8 7 S 10 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=792 $D=0
M9 12 5 7 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1364 $Y=792 $D=0
M10 VDD! B 12 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1580 $Y=792 $D=0
M11 OUT 7 VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1796 $Y=792 $D=0
.ENDS
***************************************

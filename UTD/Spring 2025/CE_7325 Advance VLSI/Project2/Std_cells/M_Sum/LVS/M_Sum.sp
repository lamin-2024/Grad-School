* SPICE NETLIST
***************************************

.SUBCKT M_Sum GND! VDD! A B C D OUT
** N=22 EP=7 IP=0 FDC=14
M0 7 A GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=144 $D=1
M1 GND! B 7 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=144 $D=1
M2 7 C GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=144 $D=1
M3 OUT D 7 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=144 $D=1
M4 10 C OUT GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1148 $Y=144 $D=1
M5 12 B 10 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1364 $Y=144 $D=1
M6 GND! A 12 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1580 $Y=144 $D=1
M7 8 A VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=792 $D=0
M8 VDD! B 8 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=792 $D=0
M9 8 C VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=792 $D=0
M10 OUT D 8 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=792 $D=0
M11 11 C OUT VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1148 $Y=792 $D=0
M12 13 B 11 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1364 $Y=792 $D=0
M13 VDD! A 13 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1580 $Y=792 $D=0
.ENDS
***************************************

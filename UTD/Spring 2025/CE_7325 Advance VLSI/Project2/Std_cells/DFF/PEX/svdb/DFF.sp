* SPICE NETLIST
***************************************

.SUBCKT DFF GND! VDD! D R CLK OUT
** N=41 EP=6 IP=0 FDC=30
M0 13 D GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=144 $D=1
M1 7 5 13 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=716 $Y=144 $D=1
M2 15 4 7 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=932 $Y=144 $D=1
M3 GND! 6 15 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1364 $Y=144 $D=1
M4 6 7 GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1580 $Y=144 $D=1
M5 GND! R 6 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1796 $Y=144 $D=1
M6 GND! CLK 5 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=2444 $Y=144 $D=1
M7 4 5 GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=2660 $Y=144 $D=1
M8 11 R GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=3524 $Y=144 $D=1
M9 GND! 10 11 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=3740 $Y=144 $D=1
M10 19 11 GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=3956 $Y=144 $D=1
M11 10 5 19 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=4388 $Y=144 $D=1
M12 21 4 10 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=4604 $Y=144 $D=1
M13 GND! 6 21 GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=5036 $Y=144 $D=1
M14 OUT 10 GND! GND! nmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=5252 $Y=144 $D=1
M15 14 D VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=284 $Y=792 $D=0
M16 7 4 14 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=500 $Y=792 $D=0
M17 16 5 7 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1148 $Y=792 $D=0
M18 VDD! 6 16 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1364 $Y=792 $D=0
M19 17 7 VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1580 $Y=792 $D=0
M20 6 R 17 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=1796 $Y=792 $D=0
M21 VDD! CLK 5 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=2444 $Y=792 $D=0
M22 4 5 VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=2660 $Y=792 $D=0
M23 18 R 11 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=3524 $Y=792 $D=0
M24 VDD! 10 18 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=3740 $Y=792 $D=0
M25 20 11 VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=3956 $Y=792 $D=0
M26 10 4 20 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=4172 $Y=792 $D=0
M27 22 5 10 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=4820 $Y=792 $D=0
M28 VDD! 6 22 VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=5036 $Y=792 $D=0
M29 OUT 10 VDD! VDD! pmos_rvt L=2e-08 W=1.08e-07 nfin=4 $X=5252 $Y=792 $D=0
.ENDS
***************************************

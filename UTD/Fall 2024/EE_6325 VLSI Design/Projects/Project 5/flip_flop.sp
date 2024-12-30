HSPICE setup file for 3 Input cells
$ Name: Lamin Jammeh
$ UTD_ID: dal852207
$ CE6325 Proj5 Fall2024

$ transistor model this includes files generated from cadence virtuoso with the run.pex
.include "/proj/cad/library/mosis/GF65_LPe/cmos10lpe_CDS_oa_dl064_11_20160415/models/YI-SM00030/Hspice/models/design.inc"
.include "Flip_Flop.pex.sp"

.option post runlvl=5

$ define the name for the circuit under test and ports
xi GND! Q VDD! CLK D R Flip_Flop

$define Power Supply as Vdd = 1.2
Vdd VDD! GND! 1.2v
Vss GND! 0 0



$ define Simulation parameters


.PARAM SR = 30ps									$ Slew Rate
.PARAM Tclk = 20ns										$ clk high and low time
.PARAM T_D = 40.01ns										$ D input high and low time						
.PARAM T_R1 = 2ns								                $ initial low time
.PARAM T_R2 = 3ns								                $ High time
.PARAM PERIOD1 = '2*Tclk'
.PARAM PERIOD2 = '2*T_D'
.PARAM PERIOD3 = '2*T_R1'
.PARAM T_DI = 19.5ns									$inital Delay for input D

$generate a clk signal using the pulse function
VCLK CLK 0 PULSE (0 1.2 0 SR SR Tclk PERIOD1)

$generate a D input signal using the pulse function
V_IN D 0 PULSE (0 1.2 T_DI  SR SR T_D PERIOD2)

$generate a R input signal using the pulse function
V_R R 0 PWL (0 0 0.9n 0 1n 1.2 1.5n 1.2 1.6n 0 )

$ Load capacitance = 55pFarad
Cout Q GND! 55f

$ Type of HSPICE Simulation = Transient Analysis with 1ps step for 20ns durationF
.tran 1ps 300ns

$ Adding a sweep of 0.1u to 1.8u in steps of 0.1u the Transient analysis
$ .tran 1ps 400ns sweep WP 0.1u 1.8u 0.1u
 
.measure tran trise trig v(V_IN) val = 0.6 fall=1 targ v(Q) val = 0.6 rise=1		        $measure thl at 0.6v
.measure tran tfall trig v(V_IN) val = 0.6 rise=1 targ v(Q) val = 0.6 fall=1		        $measure tpl at 0.6v
.measure tran tfall trig v(V_IN) val = 0.6 rise=1 targ v(Q) val = 0.6 fall=1		        $measure tpl at 0.6v
.measure tavg param  = '(trise + tfall)/2'										$calculate average delay
.measure tdiff param = 'abs(trise - tfall)'										$calculate delay difference
.measure delay param = 'max(trise, tfall)'										$calculate worst delay 

$Calculate the energy dessipated during the delay
$method1
.measure tran iavg avg i(vdd) from=0  to=20n									$average current in one clock cycle
.measure energy param = '1.2 * iavg * 300n'										$calculate energy in one clock cycle
.measure edp1   param = 'abs(delay * energy)'


.end
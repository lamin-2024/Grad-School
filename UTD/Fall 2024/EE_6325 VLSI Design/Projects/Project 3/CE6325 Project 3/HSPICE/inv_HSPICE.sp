$ HSPICE setup file for Proj3
$ Name: Lamin Jammeh
$ UTD_ID: dal852207
$ CE6325 Proj3 Fall2024

$ transistor model this includes files generated from cadence virtuoso with the run.pex
.include "/proj/cad/library/mosis/GF65_LPe/cmos10lpe_CDS_oa_dl064_11_20160415/models/YI-SM00030/Hspice/models/design.inc"
.include "inv.pex.sp"

.option post runlvl=5

$ define the name for the circuit under test and ports
xi GND! OUT VDD! IN inv

$define Power Supply as Vdd = 1.2
Vdd VDD! GND! 1.2v			

$ define Simulation parameters

.PARAM SR = 30ps									$ Slew Rate
.PARAM T1 = 0ns										$ Anticipated starting point
.PARAM T2 = 1ns																
.PARAM T3 = 'T2 + SR'									$ Ramp down using Slew rate
.PARAM T4 = 'T3 + T2'
.PARAM T5 = 'T4 + SR'
.PARAM T6 = "T5 + T2'

$define an input signal for the simulation 
VIN IN 0 PWL (T1 0.8*Vdd T2 0.8*Vdd T3 0.2*Vdd T4 0.2*Vdd T5 0.8*Vdd T6 0.8*Vdd)

$ Load capacitance = 27pFarad
Cout OUT GND! 27f

$ Type of HSPICE Simulation = Transient Analysis with 1ps step for 10ns duration
.tran 1ps 10ns
$ Adding a sweep of 0.1u to 1.8u in steps of 0.1u the Transient analysis
 .tran 1ps 10ns sweep WP 0.1u 1.8u 0.1u
 
.measure tran trise trig v(IN) val = 0.6 fall=1 targ v(OUT) val = 0.6 rise=1		        $measure thl at 0.6v
.measure tran tfall trig v(IN) val = 0.6 rise=1 targ v(OUT) val = 0.6 fall=1		        $measure tpl at 0.6v
.measure tavg param  = '(trise + tfall)/2'										$calculate average delay
.measure tdiff param = 'abs(trise - tfall)'										$calculate delay difference
.measure delay param = 'max(trise, tfall)'										$calculate worst delay 

$Calculate the energy dessipated during the delay
$method1
.measure tran iavg avg i(vdd) from=0  to=10n									$average current in one clock cycle
.measure energy param = '1.2 * iavg * 10n'										$calculate energy in one clock cycle
.measure edp1   param = 'abs(delay * energy)'

$method2
$.measure tran t1 when v(IN) =1.19 fall=1
$.measure tran t2 when v(OUT)=1.19 rise=1
$.measure tran t3 when v(IN) =0.01 rise=1
$.measure tran t4 when v(OUT)=0.01 fall=1
$.measure tran i1 avg i(vdd) from=t1 to=t2										$average current when output rise 
$.measure tran i2 avg i(vdd) from=t3 to=t4										$average current when output fall 
$.measure energy1 param = '1.2 * i1 * (t2-t1)'									$calculate energy when output rise
$.measure energy2 param = '1.2 * i2 * (t3-t4)'									$calculate energy when output fall
$.measure energysum param = 'energy1 + energy2'
$.measure edp2 param = 'abs(delay * energysum)'

.end

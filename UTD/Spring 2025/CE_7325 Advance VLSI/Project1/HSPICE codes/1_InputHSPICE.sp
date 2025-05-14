$ HSPICE setup file for INV
$ Name: Lamin Jammeh & Mark Ivey
$ UTD_ID: dal852207 MXI240020
$ CE7325 Project1

$ transistor model this includes files generated from cadence virtuoso with the run.pex
.include "/proj/cad/library/mosis/GF65_LPe/cmos10lpe_CDS_oa_dl064_11_20160415/models/YI-SM00030/Hspice/models/design.inc"
.include "INV.pex.sp"

.option post runlvl=5

$ define the name for the circuit under test and ports
xi GND! OUT VDD! IN INV

$define Power Supply as Vdd = 0.7v
Vdd VDD! GND! 0.7v			

$ define Simulation parameters

.PARAM SR = 14ps									$ Slew Rate
.PARAM T1 = 0ns										$ Anticipated starting point
.PARAM T2 = 1ns																
.PARAM T3 = 'T2 + SR'									$ Ramp down using Slew rate
.PARAM T4 = 'T3 + T2'
.PARAM T5 = 'T4 + SR'
.PARAM T6 = "T5 + T2'

$define an input signal for the simulation 
VIN IN 0 PWL (T1 Vdd T2 Vdd T3 0v T4 0v T5 Vdd T6 Vdd)

$ Load capacitance = 10fFarad
Cout OUT GND! 10f

$ Type of HSPICE Simulation = Transient Analysis with 1ps step for 3000ps duration
.tran 1ps 3000ps

 
.end
$ HSPICE setup file for INV
$ Name: Lamin Jammeh & Mark Ivey
$ UTD_ID: dal852207 MXI240020
$ CE7325 Project1

$ transistor model this includes files generated from cadence virtuoso with the run.pex
.include "/proj/cad/library/mosis/GF65_LPe/cmos10lpe_CDS_oa_dl064_11_20160415/models/YI-SM00030/Hspice/models/design.inc"
.include "NAND3.pex.sp"

.option post runlvl=5

$ define the name for the circuit under test and ports
xi OUT GND! VDD! A B C NAND3

$define Power Supply as Vdd = 0.7
Vdd VDD! GND! 0.7v			

$ define Simulation parameters

.PARAM SR = 14ps									$ Slew Rate
.PARAM T1 = 0ns										$ Anticipated starting point
.PARAM T2 = 2ns																
.PARAM T3 = 'T2 + SR'								$ Ramp down using Slew rate
.PARAM T4 = 'T3 + T2'								$ first hold time

.PARAM T5 = 'T4 + SR'                               $ Ramp up using slew rate
.PARAM T6 = 'T5 + T2'                               $ second hold time

.PARAM T7 = 'T6 + SR'								$ Ramp down using Slew rate
.PARAM T8 = 'T7 + T2'								$ third hold time

.PARAM T9  = 'T8 + SR'                              $ Ramp up using slew rate
.PARAM T10 = 'T9 + T2'                              $ fourth hold time

$define the input signals A, B and C for the simulation usig the possible logic combinations [(0,0,0) (0,0,1) (0,1,0) (0,1,1) (1,0,0) (1,0,1) (1,1,0) (1,1,1)]
VIN1 A 0 PWL (T1 0v T2 0v T3 0v  T4 0v  T5 Vdd T6 Vdd T7 Vdd T8 Vdd T9 Vdd T10 Vdd)

VIN2 B 0 PWL (T1 0v T2 0v T3 0v  T4 0v  T5 Vdd T6 Vdd T7 0v  T8 0v  T9 Vdd T10 Vdd) 

VIN3 C 0 PWL (T1 0v T2 0v T3 Vdd T4 Vdd T5 0v  T6 0v  T7 Vdd T8 Vdd T9 Vdd T10 Vdd) 

$ Load capacitance = 10fFarad
Cout OUT GND! 10f

$ Type of HSPICE Simulation = Transient Analysis with 1ps step for 3000ps duration
.tran 1ps 3000ps

.end

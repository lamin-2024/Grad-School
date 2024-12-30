#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Wed Dec  4 20:41:08 2024                
#                                                     
#######################################################

#@(#)CDS: Innovus v17.10-p006_1 (64bit) 05/31/2017 11:06 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 17.10-p006_1 NR170516-1601/17_10-UB (database version 2.30, 378.7.1) {superthreading v1.44}
#@(#)CDS: AAE 17.10-p003 (64bit) 05/31/2017 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 17.10-p002_1 () May 18 2017 07:46:32 ( )
#@(#)CDS: SYNTECH 17.10-p001_1 () May 17 2017 01:24:45 ( )
#@(#)CDS: CPE v17.10-p003
#@(#)CDS: IQRC/TQRC 16.1.1-s140 (64bit) Fri Mar 17 16:46:12 PDT 2017 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set init_gnd_net GND!
set init_lef_file ../gf65.lef
set init_verilog ../../synopsys/mapped_netlist.v
set init_pwr_net VDD!
init_design
getIoFlowFlag
setFPlanRowSpacingAndType 7.209 1
setIoFlowFlag 0
floorPlan -flip n -site CoreSite -r 1 0.7 5 5 5 5
uiSetTool select
getIoFlowFlag
fit
clearGlobalNets
globalNetConnect VDD! -type tiehi -inst *
globalNetConnect GND! -type tielo -inst *
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer M6 -stacked_via_bottom_layer M1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {GND! VDD!} -type core_rings -follow core -layer {top M1 bottom M1 left M2 right M2} -width {top 0.2 bottom 0.2 left 0.2 right 0.2} -spacing {top 0.2 bottom 0.2 left 0.2 right 0.2} -offset {top 0.78 bottom 0.78 left 0.78 right 0.78} -center 0 -extend_corner {} -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
setRouteMode -earlyGlobalHonorMsvRouteConstraint false -earlyGlobalRoutePartitionPinGuide true
setEndCapMode -reset
setEndCapMode -boundary_tap false
setNanoRouteMode -quiet -droutePostRouteSpreadWire 1
setUsefulSkewMode -maxSkew false -noBoundary false -useCells {} -maxAllowedDelay 1
setPlaceMode -reset
setPlaceMode -congEffort medium -timingDriven 0 -modulePlan 0 -clkGateAware 0 -powerDriven 0 -ignoreScan 0 -reorderScan 0 -ignoreSpare 0 -placeIOPins 1 -moduleAwareSpare 0 -preserveRouting 0 -rmAffectedRouting 0 -checkRoute 0 -swapEEQ 0
setPlaceMode -fp false
placeDesign
getFillerMode -quiet
addFiller -cell Filler_cell -prefix FILLER
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
saveNetlist FIR_Filter_Project1_1.v
set dbgLefDefOutVersion 5.6
global dbgLefDefOutVersion
set dbgLefDefOutVersion 5.6
defOut -floorplan -netlist -routing FIR_Filter_Project1_1.def
set dbgLefDefOutVersion 5.8
set dbgLefDefOutVersion 5.8

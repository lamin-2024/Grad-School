##############################################################################
# Template generated by PrimeLib T-2022.03-SP1 (built on Apr 12, 2022 13:01:04) #
# PrimeLib Path: /proj/cad/synopsys/synopsys_2021/primelib/T-2022.03-SP1/linux64/bin/primelib #
# Host Name: engnx03a.utdallas.edu, User Name: dal852207, PID: 5755 #
# Directory: /home/eng/d/dal852207/cad/gf65/primelib_gf65 #
# Date Sat, 09 Nov 2024 20:18:31 CST #
#                                                                            #
# Copyright (C) 2022 Synopsys Inc.                                #
# This file contains confidential and proprietry information.                #
# All rights reserved.                                                       #
#                                                                            #
##############################################################################

set tempTestColl [ SBTestCollection automap ]


# Specifies the version of the template API expected by this file.
$tempTestColl setTemplateVer 7

## 
## Configuration Flags
$tempTestColl setConfigurationFlags { doTiming doPower }

## 
## Formal Ports
$tempTestColl makeFormalPorts {VA VB VC VSS VDD OUT}
$tempTestColl setParameter retention_ports {}
$tempTestColl setParameter synch_controls {}
$tempTestColl setParameter clock_ports {}
$tempTestColl setParameter asynch_ports {}
$tempTestColl setParameter asynch_ports_active_state {}

## 
## Tests

## 
## Test delay__VB__hl__OUT__lh
set tempTest [ SBTest "delay__VB__hl__OUT__lh" ]
$tempTest setTargets { delay__VB__hl__OUT__lh Cin__VB__hl Tout__OUT__lh cap_energy__OUT__lh energy1__VB__hl__OUT__lh__VDD energy__VB__hl__OUT__lh leakage_power1__VDD leakage_power2__VDD }
$tempTest setTargetInputs {
  {VB hl}}

$tempTest setTargetOutputs {
  {OUT lh}}

$tempTest setSwitchingInputs {
  {VB hl}}

$tempTest setAnalysisType tranPlus

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1

## 
## ACQ_1
set tempAcq [ SBDelayAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "VA&!VC"
$tempAcq setStateCoverage "1"
$tempAcq setAdditionalStateCoverage "1" "energy1__VB__hl__OUT__lh__VDD"
$tempAcq setAdditionalStateCoverage "1" "leakage_power1__VDD"
$tempAcq setAdditionalStateCoverage "1" "leakage_power2__VDD"
$tempAcq setAdditionalStateCoverage "1" "cap_energy__OUT__lh"
$tempAcq setAdditionalStateCoverage "1" "energy__VB__hl__OUT__lh"
$tempAcq setDoEcsmSi 0

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { VA VB VC OUT:inout } { initial_delay units ct default_slew pp energy_change_threshold energy_change_abs_threshold }

$tempWT setStimulus                  {   VA   VB   VC   OUT   } {
                   "0"            {} {   1    1    0    Z,0   }
       "initial_delay" { start out } {   -    0    -    Z,1   }
"(initial_delay)+(pp)"            {} {   -    -    -    -,-   }
}

$tempWT addMeasurements {} {
  { tin_VB               Tin        { VB start } NO_USER SYS }
  { cin_VB               Cin        { VB start } NO_USER SYS }
  { tout_OUT             Tout       { OUT out } NO_USER SYS }
  { delay_VB_OUT         delay      { VB start OUT out } NO_USER SYS }
  { energy__VB__hl__OUT__lh energy     { start pp energy_change_threshold energy_change_abs_threshold 0 } NO_USER SYS }
  { cell_power_period    export_expr { pp } }
  { energy1__VB__hl__OUT__lh__VDD energy1    { start pp energy_change_threshold energy_change_abs_threshold 0 VDD } }
  { leakage_power1__VDD  leakage_power1 { initial_delay+0.95*pp initial_delay+pp VDD } }
  { leakage_power2__VDD  leakage_power2 { initial_delay+0.90*pp initial_delay+0.95*pp VDD } }
  { cap_energy__OUT__lh  cap_energy { start pp cap_OUT OUT 0 } }
}

$tempWT bindInterface { VA VB VC OUT } { 10e-12 VB[cycle_time] VB[cycle_time] VB[default_slew] cell_power_period power_stabilization_threshold power_stabilization_threshold_absolute }
$tempAcq addWaveTable $tempWT
release_obj $tempWT

## 
## Sweep Specification
$tempAcq setTagNumTableDimensions 0 mpw

## 
## Harnesses

set tempHarness [ SBHarness default ]
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement dcvs
$tempTopOp setElementName cap_ground_OUT
$tempTopOp setOperation insert
$tempTopOp setNodes {ground_OUT 0}
$tempTopOp setParam {0}
$tempHarness addTopologyOperation $tempTopOp
release_obj $tempTopOp
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement capacitor
$tempTopOp setElementName cap_OUT
$tempTopOp setOperation insert
$tempTopOp setNodes {OUT ground_OUT}
$tempTopOp setParam {load_OUT}
$tempHarness addTopologyOperation $tempTopOp
release_obj $tempTopOp
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement dcvs
$tempTopOp setElementName cap_ground_VSS
$tempTopOp setOperation insert
$tempTopOp setNodes {ground_VSS 0}
$tempTopOp setParam {0}
$tempHarness addTopologyOperation $tempTopOp
release_obj $tempTopOp
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement capacitor
$tempTopOp setElementName cap_VSS
$tempTopOp setOperation insert
$tempTopOp setNodes {VSS ground_VSS}
$tempTopOp setParam {load_VSS}
$tempHarness addTopologyOperation $tempTopOp
release_obj $tempTopOp
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement dcvs
$tempTopOp setElementName cap_ground_VDD
$tempTopOp setOperation insert
$tempTopOp setNodes {ground_VDD 0}
$tempTopOp setParam {0}
$tempHarness addTopologyOperation $tempTopOp
release_obj $tempTopOp
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement capacitor
$tempTopOp setElementName cap_VDD
$tempTopOp setOperation insert
$tempTopOp setNodes {VDD ground_VDD}
$tempTopOp setParam {load_VDD}
$tempHarness addTopologyOperation $tempTopOp
release_obj $tempTopOp
$tempAcq addHarness $tempHarness
release_obj $tempHarness

$tempAcq setHarnessName default
$tempTest addAcquisition $tempAcq
release_obj $tempAcq

$tempTestColl addTest $tempTest
release_obj $tempTest

set tempTestColl


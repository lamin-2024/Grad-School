##############################################################################
# Template generated by PrimeLib T-2022.03-SP1 (built on Apr 12, 2022 13:01:04) #
# PrimeLib Path: /proj/cad/synopsys/synopsys_2021/primelib/T-2022.03-SP1/linux64/bin/primelib #
# Host Name: engnx03a.utdallas.edu, User Name: dal852207, PID: 4280 #
# Directory: /home/eng/d/dal852207/cad/gf65/primelib_gf65/Proj6_DRC_LVS #
# Date Thu, 28 Nov 2024 18:18:51 CST #
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
$tempTestColl makeFormalPorts {A C B D VSS VDD OUT}
$tempTestColl setParameter retention_ports {}
$tempTestColl setParameter synch_controls {}
$tempTestColl setParameter clock_ports {}
$tempTestColl setParameter asynch_ports {}
$tempTestColl setParameter asynch_ports_active_state {}

## 
## Tests

## 
## Test delay__B__lh__OUT__hl
set tempTest [ SBTest "delay__B__lh__OUT__hl" ]
$tempTest setTargets { delay__B__lh__OUT__hl Cin__B__lh Tout__OUT__hl cap_energy__OUT__hl energy1__B__lh__OUT__hl__VDD energy__B__lh__OUT__hl leakage_power1__VDD leakage_power2__VDD }
$tempTest setTargetInputs {
  {B lh}}

$tempTest setTargetOutputs {
  {OUT hl}}

$tempTest setSwitchingInputs {
  {B lh}}

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
$tempAcq setState "A&C&D"
$tempAcq setStateCoverage "1"
$tempAcq setAdditionalStateCoverage "1" "leakage_power1__VDD"
$tempAcq setAdditionalStateCoverage "1" "energy__B__lh__OUT__hl"
$tempAcq setAdditionalStateCoverage "1" "energy1__B__lh__OUT__hl__VDD"
$tempAcq setAdditionalStateCoverage "1" "cap_energy__OUT__hl"
$tempAcq setAdditionalStateCoverage "1" "leakage_power2__VDD"
$tempAcq setDoEcsmSi 0

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { A C B D OUT:inout } { initial_delay units ct default_slew pp energy_change_threshold energy_change_abs_threshold }

$tempWT setStimulus                  {   A    C    B    D    OUT   } {
                   "0"            {} {   1    1    0    1    Z,1   }
       "initial_delay" { start out } {   -    -    1    -    Z,0   }
"(initial_delay)+(pp)"            {} {   -    -    -    -    -,-   }
}

$tempWT addMeasurements {} {
  { tin_B                Tin        { B start } NO_USER SYS }
  { cin_B                Cin        { B start } NO_USER SYS }
  { tout_OUT             Tout       { OUT out } NO_USER SYS }
  { delay_B_OUT          delay      { B start OUT out } NO_USER SYS }
  { energy__B__lh__OUT__hl energy     { start pp energy_change_threshold energy_change_abs_threshold 0 } NO_USER SYS }
  { cell_power_period    export_expr { pp } }
  { energy1__B__lh__OUT__hl__VDD energy1    { start pp energy_change_threshold energy_change_abs_threshold 0 VDD } }
  { leakage_power1__VDD  leakage_power1 { initial_delay+0.95*pp initial_delay+pp VDD } }
  { leakage_power2__VDD  leakage_power2 { initial_delay+0.90*pp initial_delay+0.95*pp VDD } }
  { cap_energy__OUT__hl  cap_energy { start pp cap_OUT OUT 0 } }
}

$tempWT bindInterface { A C B D OUT } { 10e-12 B[cycle_time] B[cycle_time] B[default_slew] cell_power_period power_stabilization_threshold power_stabilization_threshold_absolute }
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


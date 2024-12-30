##############################################################################
# Template generated by PrimeLib T-2022.03-SP1 (built on Apr 12, 2022 13:01:04) #
# PrimeLib Path: /proj/cad/synopsys/synopsys_2021/primelib/T-2022.03-SP1/linux64/bin/primelib #
# Host Name: engnx03a.utdallas.edu, User Name: dal852207, PID: 4303 #
# Directory: /home/eng/d/dal852207/cad/gf65/primelib_gf65/Proj6_DRC_LVS #
# Date Thu, 28 Nov 2024 16:16:33 CST #
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
$tempTestColl makeFormalPorts {VSS D CLK Q R VDD}
$tempTestColl setParameter retention_ports {}
$tempTestColl setParameter synch_controls {}
$tempTestColl setParameter clock_ports {CLK}
$tempTestColl setParameter asynch_ports {R}
$tempTestColl setParameter asynch_ports_active_state {R 01 Q 10}

## 
## Tests

## 
## Test hold_hbm__D__lh__CLK__hl
set tempTest [ SBTest "hold_hbm__D__lh__CLK__hl" ]
$tempTest setTargets { hold_hbm__D__lh__CLK__hl }
$tempTest setTargetInputs {
  {D lh}}

$tempTest setTargetOutputs {
  {Q hl}}

$tempTest setTargetReferences {
  {CLK hl}}

$tempTest setSwitchingInputs {
  {D lh}}

$tempTest setSwitchingRefs {
  {CLK hl}}

$tempTest setAnalysisType tranPlus

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1

## 
## ACQ_1
set tempAcq [ SBConstraintHBMAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "!R"
$tempAcq setStateCoverage "1"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { Q:out R D CLK } { initial_delay units ct default_slew stable driver_delay_D driver_delay_CLK hold min_hold max_hold opt_tolerance init_hbm degrade_hold }

$tempWT setStimulus                           {   R    D    CLK  Q     } {
                              "0"          {} {   0    0    1    1     }
                  "initial_delay" { in1 out } {   -    -    0    0     }
           "(initial_delay)+hold"     { in2 } {   -    1    -    -     }
"((initial_delay)+hold)+(stable)"          {} {   -    -    -    -     }
}

$tempWT addMeasurements {} {
  { tin_CLK              Tin        { CLK in1 } NO_USER SYS }
  { tin_D                Tin        { D in2 } NO_USER SYS }
  { hold_hbm_D_CLK       hold_hbm   { D in2 CLK in1 0 } NO_USER SYS }
  { tout_hbm_Q           Tout_hbm   { Q in1 0 1 } NO_USER SYS }
  { delay_hbm_CLK_Q      delay_hbm  { CLK in1 Q in1 0 } NO_USER SYS }
  { fallback_hbm_Q       fallback_hbm { Q in1 0 } NO_USER SYS }
  { sis_pass_fail        passfail_hbm { 0 D CLK } NO_USER SYS }
}

$tempWT addHbm    hold    min_hold    max_hold    delay_hbm_CLK_Q    independent   { Q relative-degradation }   { Q positive-side }   { Q 0.1 -1 }   { Q 1e-11 1e-08 -1 }  { (fallback_hbm__Q__hl_trig-tout_hbm__Q__hl_targ) (fallback_hbm__Q__hl_targ-tout_hbm__Q__hl_trig) }   {  }  { Q hl }  {  }  { hold_hbm__D__lh__CLK__hl_trig hold_hbm__D__lh__CLK__hl_targ tin__D__lh_trig tin__D__lh_targ tin__CLK__hl_trig tin__CLK__hl_targ tout_hbm__Q__hl_trig tout_hbm__Q__hl_targ delay_hbm__CLK__hl__Q__hl_trig delay_hbm__CLK__hl__Q__hl_targ } {  } { relative Q delay_hbm__CLK__hl__Q__hl_value } { hold_hbm__D__lh__CLK__hl_value } {  } {  } pass None opt_tolerance (driver_delay_CLK-driver_delay_D)+(1.99*opt_tolerance)+(0.15*(slew_D+slew_CLK)) driver_delay_CLK-driver_delay_D min_hold "1"
$tempWT bindInterface { Q R D CLK } { 10e-12 D[cycle_time] D[cycle_time] D[default_slew] max(D[stable_time],Q[stable_time]) (slew_D*0.5)/(0.9-0.1) (slew_CLK*0.5)/(0.9-0.1) D[max_hold] D[min_hold] D[max_hold] D[constraint_resolution] driver_delay_CLK-driver_delay_D 0.0 }
$tempAcq addWaveTable $tempWT
release_obj $tempWT

## 
## Initialization Acquisition
$tempAcq setInitializationAcquisition initialization__ACQ_3

## 
## Sweep Specification
$tempAcq setTagNumTableDimensions 0 mpw

## 
## Harnesses

set tempHarness [ SBHarness default ]
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement capacitor
$tempTopOp setElementName cap_Q
$tempTopOp setOperation insert
$tempTopOp setNodes {Q Q[logic_low_name]}
$tempTopOp setParam {load_Q}
$tempHarness addTopologyOperation $tempTopOp
release_obj $tempTopOp
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement capacitor
$tempTopOp setElementName cap_VSS
$tempTopOp setOperation insert
$tempTopOp setNodes {VSS VSS[logic_low_name]}
$tempTopOp setParam {load_VSS}
$tempHarness addTopologyOperation $tempTopOp
release_obj $tempTopOp
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement capacitor
$tempTopOp setElementName cap_VDD
$tempTopOp setOperation insert
$tempTopOp setNodes {VDD VDD[logic_low_name]}
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


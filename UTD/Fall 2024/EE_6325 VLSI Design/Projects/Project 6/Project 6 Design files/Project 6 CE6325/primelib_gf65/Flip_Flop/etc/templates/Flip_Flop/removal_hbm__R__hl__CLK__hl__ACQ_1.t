##############################################################################
# Template generated by PrimeLib T-2022.03-SP1 (built on Apr 12, 2022 13:01:04) #
# PrimeLib Path: /proj/cad/synopsys/synopsys_2021/primelib/T-2022.03-SP1/linux64/bin/primelib #
# Host Name: engnx01a.utdallas.edu, User Name: dal852207, PID: 30885 #
# Directory: /home/eng/d/dal852207/cad/gf65/primelib_gf65 #
# Date Mon, 02 Dec 2024 13:37:16 CST #
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
## Test removal_hbm__R__hl__CLK__hl
set tempTest [ SBTest "removal_hbm__R__hl__CLK__hl" ]
$tempTest setTargets { removal_hbm__R__hl__CLK__hl }
$tempTest setTargetInputs {
  {R hl}}

$tempTest setTargetOutputs {
  {Q lh}}

$tempTest setTargetReferences {
  {CLK hl}}

$tempTest setSwitchingInputs {
  {R hl}}

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
$tempAcq setState "D"
$tempAcq setStateCoverage "1"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { Q:out R D CLK } { initial_delay units ct default_slew stable driver_delay_R driver_delay_CLK removal min_removal max_removal opt_tolerance glitch_threshold_Q init_hbm degrade_removal }

$tempWT setStimulus                              {   R    D    CLK  Q     } {
                                 "0"          {} {   1    1    1    0     }
                     "initial_delay" { in1 out } {   -    -    0    1     }
           "(initial_delay)+removal"     { in2 } {   0    -    -    -     }
"((initial_delay)+removal)+(stable)"          {} {   -    -    -    -     }
}

$tempWT addMeasurements {} {
  { tin_CLK              Tin        { CLK in1 } NO_USER SYS }
  { tin_R                Tin        { R in2 } NO_USER SYS }
  { removal_hbm_R_CLK    removal_hbm { R in2 CLK in1 0 } NO_USER SYS }
  { threshold_cross_Q    glitch_check_hbm { CLK in1 Q in1 glitch_threshold_Q } NO_USER SYS }
  { sis_pass_fail        passfail_hbm { 0 R CLK } NO_USER SYS }
}

$tempWT addHbm    removal    min_removal    max_removal    threshold_cross_Q    independent   {  }   {  }   {  }   {  }  {  }   {  }  {  }  {  }  { removal_hbm__R__hl__CLK__hl_trig removal_hbm__R__hl__CLK__hl_targ tin__R__hl_trig tin__R__hl_targ tin__CLK__hl_trig tin__CLK__hl_targ } { glitch_check_hbm__CLK__hl__Q__lh_value } {  } { removal_hbm__R__hl__CLK__hl_value } {  } {  } fail None opt_tolerance (driver_delay_CLK-driver_delay_R)+(1.99*opt_tolerance)+(0.15*(slew_R+slew_CLK)) driver_delay_CLK-driver_delay_R min_removal "1"
$tempWT bindInterface { Q R D CLK } { 10e-12 R[cycle_time] R[cycle_time] R[default_slew] max(R[stable_time],Q[stable_time]) (slew_R*0.5)/(0.9-0.1) (slew_CLK*0.5)/(0.9-0.1) R[max_removal] R[min_removal] R[max_removal] R[constraint_resolution] Q[glitch_low_threshold] driver_delay_CLK-driver_delay_R 0.0 }
$tempAcq addWaveTable $tempWT
release_obj $tempWT

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


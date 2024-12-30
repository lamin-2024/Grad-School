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
## Test ncmpw_hbm__CLK__lh__CLK__hl
set tempTest [ SBTest "ncmpw_hbm__CLK__lh__CLK__hl" ]
$tempTest setTargets { ncmpw_hbm__CLK__lh__CLK__hl }
$tempTest setTargetInputs {
  {CLK lh}}

$tempTest setTargetOutputs {
  {Q lh}}

$tempTest setTargetReferences {
  {CLK hl}}

$tempTest setSwitchingInputs {
  {CLK lh}}

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
set tempAcq [ SBMPWHBMAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "D&!R"
$tempAcq setStateCoverage "1"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { Q:out R D CLK } { initial_delay units ct default_slew stable ncmpw min_ncmpw max_ncmpw opt_tolerance init_hbm degrade_ncmpw }

$tempWT setStimulus                            {   R    D    CLK  Q     } {
                               "0"          {} {   0    1    0    0     }
                   "initial_delay"     { in1 } {   -    -    1    -     }
           "(initial_delay)+ncmpw" { in2 out } {   -    -    0    1     }
"((initial_delay)+ncmpw)+(stable)"          {} {   -    -    -    -     }
}

$tempWT addMeasurements {} {
  { tin_hbm_CLK          Tin_hbm    { CLK in1 } NO_USER SYS }
  { ncmpw_hbm_CLK        ncmpw_hbm  { CLK in1 CLK in2 } NO_USER SYS }
  { tout_hbm_Q           Tout_hbm   { Q in2 1 1 } NO_USER SYS }
  { delay_hbm_CLK_Q      delay_hbm  { CLK in2 Q in2 1 } NO_USER SYS }
  { fallback_hbm_Q       fallback_hbm { Q in2 1 } NO_USER SYS }
  { sis_pass_fail        passfail_hbm { 0 CLK CLK } NO_USER SYS }
}

$tempWT addHbm    ncmpw    min_ncmpw    max_ncmpw    delay_hbm_CLK_Q    independent   { Q relative-degradation }   { Q positive-side }   { Q 0.1 -1 }   { Q 1e-11 1e-08 -1 }  { (fallback_hbm__Q__lh_trig-tout_hbm__Q__lh_targ) (fallback_hbm__Q__lh_targ-tout_hbm__Q__lh_trig) }   {  }  { Q lh }  {  }  { ncmpw_hbm__CLK__lh__CLK__hl_trig ncmpw_hbm__CLK__lh__CLK__hl_targ tin_hbm__CLK__lh_trig tin_hbm__CLK__lh_targ tout_hbm__Q__lh_trig tout_hbm__Q__lh_targ delay_hbm__CLK__hl__Q__lh_trig delay_hbm__CLK__hl__Q__lh_targ } {  } { relative Q delay_hbm__CLK__hl__Q__lh_value } { ncmpw_hbm__CLK__lh__CLK__hl_value } {  } {  } expand None opt_tolerance None None max_ncmpw "1"
$tempWT bindInterface { Q R D CLK } { 10e-12 CLK[cycle_time] CLK[cycle_time] CLK[default_slew] max(CLK[stable_time],Q[stable_time]) CLK[max_ncmpw] CLK[min_ncmpw] CLK[max_ncmpw] CLK[constraint_resolution] CLK[min_ncmpw] 0.0 }
$tempAcq addWaveTable $tempWT
release_obj $tempWT

## 
## Initialization Acquisition
$tempAcq setInitializationAcquisition initialization__ACQ_5

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


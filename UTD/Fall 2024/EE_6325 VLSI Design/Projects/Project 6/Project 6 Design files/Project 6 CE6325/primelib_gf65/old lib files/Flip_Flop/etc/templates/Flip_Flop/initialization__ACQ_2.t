##############################################################################
# Template generated by PrimeLib T-2022.03-SP1 (built on Apr 12, 2022 13:01:04) #
# PrimeLib Path: /proj/cad/synopsys/synopsys_2021/primelib/T-2022.03-SP1/linux64/bin/primelib #
# Host Name: engnx03a.utdallas.edu, User Name: dal852207, PID: 4567 #
# Directory: /home/eng/d/dal852207/cad/gf65/primelib_gf65 #
# Date Sat, 23 Nov 2024 15:18:55 CST #
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
## Test initialization
set tempTest [ SBTest "initialization" ]
$tempTest setTargets { initialization }
$tempTest setTargetOutputs {
  {Q lh}}

$tempTest setSwitchingInputs {
  {CLK hl}}

$tempTest setSwitchingRefs {
  {CLK lh}}

$tempTest setAnalysisType tranPlus

## 
## Sweep Specification

## 
## Harnesses
$tempTest setAcquire 1

## 
## ACQ_2
set tempAcq [ SBInitializationAcquisition "ACQ_2" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "1"
$tempAcq setStateCoverage "1"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { Q:out R D CLK } { initial_delay ct units default_slew }

$tempWT setStimulus                         {   R    D    CLK  Q     } {
                                "0"      {} {   0    1    1    1     }
                    "initial_delay"      {} {   -    -    0    1     }
          "initial_delay+0.5*units" { in1 } {   -    0    -    -     }
"(initial_delay+0.5*units)+(units)"      {} {   -    -    -    -     }
}

$tempWT addMeasurements {} {
  { initialization       initialization { Flip_Flop macro } NO_USER SYS }
}

$tempWT bindInterface { Q R D CLK } { cell_initial_delay cell_cycle_time cell_cycle_time Q[default_slew] }
$tempAcq addWaveTable $tempWT
release_obj $tempWT

## 
## Sweep Specification

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

##############################################################################
# Template generated by PrimeLib T-2022.03-SP1 (built on Apr 12, 2022 13:01:04) #
# PrimeLib Path: /proj/cad/synopsys/synopsys_2021/primelib/T-2022.03-SP1/linux64/bin/primelib #
# Host Name: engnx03a.utdallas.edu, User Name: dal852207, PID: 4303 #
# Directory: /home/eng/d/dal852207/cad/gf65/primelib_gf65/Proj6_DRC_LVS #
# Date Thu, 28 Nov 2024 16:33:24 CST #
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
$tempTestColl makeFormalPorts {A OUT B VDD VSS}
$tempTestColl setParameter retention_ports {}
$tempTestColl setParameter synch_controls {}
$tempTestColl setParameter clock_ports {}
$tempTestColl setParameter asynch_ports {}
$tempTestColl setParameter asynch_ports_active_state {}

## 
## Tests

## 
## Test Cin__VSS__lh
set tempTest [ SBTest "Cin__VSS__lh" ]
$tempTest setTargets { Cin__VSS__lh }
$tempTest setTargetInputs {
  {VSS lh}}

$tempTest setSwitchingInputs {
  {VSS lh}}

$tempTest setAnalysisType tranPlus

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1

## 
## ACQ_1
set tempAcq [ SBInputCapacitanceAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "!A&!B&!OUT&!VDD"
$tempAcq setStateCoverage "1"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { A B VDD VSS } { initial_delay units ct default_slew pp }

$tempWT setStimulus            {   A    B    VDD  VSS   } {
                   "0"      {} {   0    0    0    0     }
       "initial_delay" { in1 } {   -    -    -    1     }
"(initial_delay)+(pp)"      {} {   -    -    -    -     }
}

$tempWT addMeasurements {} {
  { cin_VSS              Cin        { VSS in1 } NO_USER SYS }
}

$tempWT bindInterface { A B VDD VSS } { 10e-12 VSS[cycle_time] VSS[cycle_time] VSS[default_slew] cell_power_period }
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
$tempTopOp setElementName cap_OUT
$tempTopOp setOperation insert
$tempTopOp setNodes {OUT OUT[logic_low_name]}
$tempTopOp setParam {load_OUT}
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


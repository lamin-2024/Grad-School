#####################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution 16.23-s049_1
#   on 04/27/2025 11:00:12
#
# This file can only be run in Genus Common UI mode.
#
#####################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version 16.23-s049_1


# Remove Existing Design
###########################################################
if {[::legacy::find -design design:MSDAP] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  delete_obj design:MSDAP
}


# Source INIT Setup file
########################################################
source genus_invs_des/genus.genus_init.tcl

## Use below command till fix of CCR 1316394
::legacy::set_attribute qrc_tech_file /proj/cad/library/asap7/asap7sc7p5t_27/qrc/qrcTechFile_typ03_scaled4xV06
read_metric -id current genus_invs_des/genus.metrics.json

source genus_invs_des/genus.g.gz
puts "\n** Restoration Completed **\n"


# Data Integrity Check
###########################################################
# program version
if {"[string_representation [::legacy::get_attribute program_version /]]" != "16.23-s049_1"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden program_version: 16.23-s049_1  current program_version: [string_representation [::legacy::get_attribute program_version /]]"
}
# license
if {"[string_representation [::legacy::get_attribute startup_license /]]" != "Genus_Synthesis"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden license: Genus_Synthesis  current license: [string_representation [::legacy::get_attribute startup_license /]]"
}
# slack
set _slk_ [::legacy::get_attribute slack design:MSDAP]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "32083.5"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack: 32083.5,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
if {"[string_representation [::legacy::get_attribute slack_by_mode design:MSDAP]]" != "{{mode:MSDAP/PVT_0P63V_100C.setup_view 32083.5}}"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack_by_mode: {{mode:MSDAP/PVT_0P63V_100C.setup_view 32083.5}}  current slack_by_mode: [string_representation [::legacy::get_attribute slack_by_mode design:MSDAP]]"
}
# tns
set _tns_ [::legacy::get_attribute tns design:MSDAP]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "0"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden tns: 0,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [::legacy::get_attribute cell_area design:MSDAP]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "143744"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden cell area: 143744,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [::legacy::get_attribute net_area design:MSDAP]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "46662"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden net area: 46662,  current net area: $_net_area_"
}
unset _net_area_
# library domain count
if {[llength [::legacy::find /libraries -library_domain *]] != "1"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden # library domains: 1  current # library domains: [llength [::legacy::find /libraries -library_domain *]]"
}

#Start up Innovus with "innovus -stylus"
set_db design_process_node 7
set_db timing_analysis_cppr both
set_db timing_analysis_type ocv
set_library_unit -time 1ps

# Read libraries and SRAM macros
read_physical -lef { \
/proj/cad/library/asap7/asap7sc7p5t_27/techlef_misc/asap7_tech_4x_201209.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_R_4x_201211.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_L_4x_201211.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_SL_4x_201211.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_SRAM_4x_201211.lef \
/home/eng/i/dal852207/cad_ASIC/genius_syn/Final_proj/post_genus/PnR/lef/SRAM1RW128x12.lef \
/home/eng/i/dal852207/cad_ASIC/genius_syn/Final_proj/post_genus/PnR/lef/SRAM1RW256x8.lef \
/home/eng/i/dal852207/cad_ASIC/genius_syn/Final_proj/post_genus/PnR/lef/SRAM2RW16x8.lef }

# Define corners
read_mmmc mmmc.tcl

# Read netlist
read_netlist { /home/eng/i/dal852207/cad_ASIC/genius_syn/Final_proj/post_genus/PnR/MSDAP_mapped.v } -top MSDAP
init_design

# Power intent
read_power_intent -cpf power_spec.cpf
commit_power_intent

# Exclude problematic std cells
source set_dont_use.tcl

set_db design_flow_effort standard
set_db route_design_bottom_routing_layer 2
set_db route_design_top_routing_layer 7
set_db timing_analysis_async_checks no_async
set_db generate_special_via_rule_preference { M7_M6widePWR1p152 M6_M5widePWR1p152 M5_M4widePWR0p864 M4_M3widePWR0p864 M3_M2widePWR0p936 }
set_db route_design_with_via_in_pin true

# Floorplan and macro placement
source -echo -verbose floorplan.tcl


# Routing tracks
add_tracks -honor_pitch -offsets { M4 horiz 0.048 M5 vert 0.048 M6 horiz 0.064 M7 vert 0.064 }

# Place blockage top/bottom
set core_lly [get_db current_design .core_bbox.ll.y]
set core_ury [expr [get_db current_design .core_bbox.ur.y] - 1.08]
set botrow [get_db rows -if {.rect.ll.y == $core_lly}]
set toprow [get_db rows -if {.rect.ur.y > $core_ury}]
create_place_blockage -area [get_db $botrow .rect] -name ROW_BLOCK_BOT
create_place_blockage -area [get_db $toprow .rect] -name ROW_BLOCK_TOP

# Add well tap cells
set_db add_well_taps_cell TAPCELL_ASAP7_75t_L
add_well_taps -cell_interval 50 -in_row_offset 10.564

# Power straps
source -echo -verbose power_straps.tcl

# I/O pins
set_db assign_pins_edit_in_batch true
edit_pin -fixed_pin -pin * -hinst MSDAP -pattern fill_optimised -layer { M5 M7 } -side bottom -start { 236.864 0 } -end { 0 0 }
set_db assign_pins_edit_in_batch false

# Placement
place_opt_design

# Clock tree
create_clock_tree_spec
ccopt_design -hold -report_dir hammer_cts_debug -report_prefix hammer_cts

# [NEW] Filler keepout → avoid fillers causing spacing violations
set_db add_fillers_cells "DECAPx1_ASAP7_75t_R DECAPx1_ASAP7_75t_L DECAPx1_ASAP7_75t_SL DECAPx1_ASAP7_75t_SRAM ..."
add_fillers

# Routing
route_design
opt_design -post_route -setup -hold -expanded_views

write_db MSDAP_FINAL -def -verilog
set_db write_stream_virtual_connection false

write_netlist MSDAP_lvs.v -top_module_first -top_module MSDAP -exclude_leaf_cells -phys -flat -exclude_insts_of_cells { TAPCELL_ASAP7_75t_R TAPCELL_ASAP7_75t_L TAPCELL_ASAP7_75t_SL TAPCELL_ASAP7_75t_SRAM TAPCELL_WITH_FILLER_ASAP7_75t_R TAPCELL_WITH_FILLER_ASAP7_75t_L TAPCELL_WITH_FILLER_ASAP7_75t_SL TAPCELL_WITH_FILLER_ASAP7_75t_SRAM FILLER_ASAP7_75t_R FILLER_ASAP7_75t_L FILLER_ASAP7_75t_SL FILLER_ASAP7_75t_SRAM FILLERxp5_ASAP7_75t_R FILLERxp5_ASAP7_75t_L FILLERxp5_ASAP7_75t_SL FILLERxp5_ASAP7_75t_SRAM } 

write_netlist MSDAP_sim.v -top_module_first -top_module MSDAP -exclude_leaf_cells -exclude_insts_of_cells { TAPCELL_ASAP7_75t_R TAPCELL_ASAP7_75t_L TAPCELL_ASAP7_75t_SL TAPCELL_ASAP7_75t_SRAM TAPCELL_WITH_FILLER_ASAP7_75t_R TAPCELL_WITH_FILLER_ASAP7_75t_L TAPCELL_WITH_FILLER_ASAP7_75t_SL TAPCELL_WITH_FILLER_ASAP7_75t_SRAM FILLER_ASAP7_75t_R FILLER_ASAP7_75t_L FILLER_ASAP7_75t_SL FILLER_ASAP7_75t_SRAM FILLERxp5_ASAP7_75t_R FILLERxp5_ASAP7_75t_L FILLERxp5_ASAP7_75t_SL FILLERxp5_ASAP7_75t_SRAM } 


# [DRC FIX]
route_design -global_detail
check_drc -limit 500 -out_file reports/drc_after_global_detail.rpt

# Reports + Save
write_db MSDAP_FINAL
if {![file isdirectory "reports"]} {
    file mkdir reports
}
report_timing -late -max_paths 3 > reports/setup.rpt
report_timing -early -max_paths 3 > reports/hold.rpt
report_power -out_file reports/power.rpt
report_area -out_file reports/area.rpt
check_drc -limit 500 -out_file reports/drc.rpt

#source the calibre tcl file to enable calibre in innovus
source /proj/cad/mentor_2021/aoi_cal_2021.1_33.19/lib/cal_enc.tcl

#exit


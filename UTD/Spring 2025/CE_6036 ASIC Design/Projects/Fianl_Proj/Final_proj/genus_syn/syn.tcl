# 1. Set root attributes
set_db hdl_error_on_blackbox true
set_db lp_insert_clock_gating  false
set_db use_tiehilo_for_const duplicate
# Genus uses 8 CPU cores by default
# set_db max_cpus_per_server 2

# 2. Define corners
read_mmmc mmmc.tcl

# 3. Read libraries and SRAM macros
read_physical -lef { \
/proj/cad/library/asap7/asap7sc7p5t_27/techlef_misc/asap7_tech_4x_201209.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_R_4x_201211.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_L_4x_201211.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_SL_4x_201211.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_SRAM_4x_201211.lef \
/home/eng/i/dal852207/cad_ASIC/genius_syn/Final_proj/genus_syn/SRAM_lef_files/SRAM1RW128x12.lef \
/home/eng/i/dal852207/cad_ASIC/genius_syn/Final_proj/genus_syn/SRAM_lef_files/SRAM1RW256x8.lef \
/home/eng/i/dal852207/cad_ASIC/genius_syn/Final_proj/genus_syn/SRAM_lef_files/SRAM2RW16x8.lef }

# 4. Read your Verilog files
set hdl_path "/home/eng/i/dal852207/cad_ASIC/genius_syn/Final_proj/genus_syn/verilog_codes"

foreach file [glob -nocomplain $hdl_path/*.v] {
    puts "Reading Verilog: $file"
    read_hdl -verilog $file
}

foreach file [glob -nocomplain $hdl_path/*.sv] {
    puts "Reading Verilog: $file"
    read_hdl -verilog $file
}

# 5. Treat SRAM macros as blackboxes (IMPORTANT!)
set_db [get_designs SRAM1RW128x12] .dont_touch true
set_db [get_designs SRAM1RW128x12] .is_blackbox true
set_db [get_designs SRAM1RW256x8] .dont_touch true
set_db [get_designs SRAM1RW256x8] .is_blackbox true
set_db [get_designs SRAM2RW16x8] .dont_touch true
set_db [get_designs SRAM2RW16x8] .is_blackbox true

# 6. Elaborate top design
set_db [get_designs MSDAP] .auto_ungroup none
set_db [get_designs R_MEM] .auto_ungroup none
set_db [get_designs DATA_MEM] .auto_ungroup none
set_db [get_designs CO_MEM] .auto_ungroup none


elaborate MSDAP
init_design -top MSDAP

# 7. Set design attributes
set_db root: .auto_ungroup none
set_units -capacitance 1.0pF
set_load_unit -picofarads 1
set_units -time 1.0ps
# add_tieoffs -high TIEHIx1_ASAP7_75t_SL -low TIELOx1_ASAP7_75t_SL -max_fanout 1 -verbose

# 8. Exclude standard cells that may cause error
source set_dont_use.tcl

# 9. Synthesize the MSDAP design
syn_generic

# Auto-preserve memories and ALUs after syn_generic
# Auto-preserve only memory SRAM instances (not inner registers)
foreach cell [concat \
    [get_cells -hierarchical *mem_0_0] \
    [get_cells -hierarchical *mem_0_1] \
    [get_cells -hierarchical *mem_0_2] \
    [get_cells -hierarchical *mem_0_3] \
] {
    if {[llength [get_cells -quiet $cell]] > 0} {
        set_db $cell .preserve size_ok
        puts "Preserved: $cell"
    }
}


syn_map

# 10. Save design
write_hdl > MSDAP_mapped.v
write_script > MSDAP_mapped.scr
write_sdc -view PVT_0P63V_100C.setup_view > MSDAP_mapped.sdc
write_sdf > MSDAP_mapped.sdf
write_design -innovus -hierarchical -gzip_files MSDAP

# 11. (Optional) Generate reports
if {![file isdirectory "reports"]} {
    file mkdir reports
}

report_timing -max_paths 3 > reports/setup.rpt
report_power > reports/power.rpt
report_area > reports/area.rpt

quit

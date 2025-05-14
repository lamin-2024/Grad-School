#####################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 04/27/2025 11:00:12
#
#####################################################################


read_mmmc genus_invs_des/genus.mmmc.tcl

read_physical -lef {/proj/cad/library/asap7/asap7sc7p5t_27/techlef_misc/asap7_tech_4x_201209.lef /proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_R_4x_201211.lef /proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_L_4x_201211.lef /proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_SL_4x_201211.lef /proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_SRAM_4x_201211.lef /home/eng/i/dal852207/cad_ASIC/genius_syn/Final_proj/genus_syn/SRAM_lef_files/SRAM1RW128x12.lef /home/eng/i/dal852207/cad_ASIC/genius_syn/Final_proj/genus_syn/SRAM_lef_files/SRAM1RW256x8.lef /home/eng/i/dal852207/cad_ASIC/genius_syn/Final_proj/genus_syn/SRAM_lef_files/SRAM2RW16x8.lef}

read_netlist genus_invs_des/genus.v.gz

init_design -skip_sdc_read

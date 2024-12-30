transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/lmnjm/OneDrive/Documents/Grad\ School/Summer\ 2024/EE417\ Programmable\ Logic\ Devices/Lecture\ 12/FINAL\ PROJECT/Controller {C:/Users/lmnjm/OneDrive/Documents/Grad School/Summer 2024/EE417 Programmable Logic Devices/Lecture 12/FINAL PROJECT/Controller/Pipeline_FIR_Controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/lmnjm/OneDrive/Documents/Grad\ School/Summer\ 2024/EE417\ Programmable\ Logic\ Devices/Lecture\ 12/FINAL\ PROJECT/DataPath {C:/Users/lmnjm/OneDrive/Documents/Grad School/Summer 2024/EE417 Programmable Logic Devices/Lecture 12/FINAL PROJECT/DataPath/Pipeline_FIR_DataPath.v}
vlog -vlog01compat -work work +incdir+C:/Users/lmnjm/OneDrive/Documents/Grad\ School/Summer\ 2024/EE417\ Programmable\ Logic\ Devices/Lecture\ 12/FINAL\ PROJECT/FIR_MAC {C:/Users/lmnjm/OneDrive/Documents/Grad School/Summer 2024/EE417 Programmable Logic Devices/Lecture 12/FINAL PROJECT/FIR_MAC/Pipeline_FIR_MAC.v}

vlog -vlog01compat -work work +incdir+C:/Users/lmnjm/OneDrive/Documents/Grad\ School/Summer\ 2024/EE417\ Programmable\ Logic\ Devices/Lecture\ 12/FINAL\ PROJECT/FIR_MAC {C:/Users/lmnjm/OneDrive/Documents/Grad School/Summer 2024/EE417 Programmable Logic Devices/Lecture 12/FINAL PROJECT/FIR_MAC/Pipeline_FIR_MAC_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Pipeline_FIR_MAC_tb

add wave *
view structure
view signals
run -all

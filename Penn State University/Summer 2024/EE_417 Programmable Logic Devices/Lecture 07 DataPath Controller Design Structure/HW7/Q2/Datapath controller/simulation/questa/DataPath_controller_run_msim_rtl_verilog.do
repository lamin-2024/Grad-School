transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/lmnjm/OneDrive/Documents/Summer\ 2024/EE417\ Programmable\ Logic\ Devices/Lecture\ 07/HW7/Q2/controller {C:/Users/lmnjm/OneDrive/Documents/Summer 2024/EE417 Programmable Logic Devices/Lecture 07/HW7/Q2/controller/Controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/lmnjm/OneDrive/Documents/Summer\ 2024/EE417\ Programmable\ Logic\ Devices/Lecture\ 07/HW7/Q2/Datapath {C:/Users/lmnjm/OneDrive/Documents/Summer 2024/EE417 Programmable Logic Devices/Lecture 07/HW7/Q2/Datapath/DataPath.v}
vlog -vlog01compat -work work +incdir+C:/Users/lmnjm/OneDrive/Documents/Summer\ 2024/EE417\ Programmable\ Logic\ Devices/Lecture\ 07/HW7/Q2/Datapath\ controller {C:/Users/lmnjm/OneDrive/Documents/Summer 2024/EE417 Programmable Logic Devices/Lecture 07/HW7/Q2/Datapath controller/DataPath_controller.v}

vlog -vlog01compat -work work +incdir+C:/Users/lmnjm/OneDrive/Documents/Summer\ 2024/EE417\ Programmable\ Logic\ Devices/Lecture\ 07/HW7/Q2/Datapath\ controller {C:/Users/lmnjm/OneDrive/Documents/Summer 2024/EE417 Programmable Logic Devices/Lecture 07/HW7/Q2/Datapath controller/DataPath_controller_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  DataPath_controller_tb

add wave *
view structure
view signals
run -all

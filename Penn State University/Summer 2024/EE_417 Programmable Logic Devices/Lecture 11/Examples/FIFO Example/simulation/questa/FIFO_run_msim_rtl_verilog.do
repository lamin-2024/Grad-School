transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/lmnjm/OneDrive/Documents/Grad\ School/Summer\ 2024/EE417\ Programmable\ Logic\ Devices/Lecture\ 11/Examples/FIFO\ Example {C:/Users/lmnjm/OneDrive/Documents/Grad School/Summer 2024/EE417 Programmable Logic Devices/Lecture 11/Examples/FIFO Example/FIFO.v}

vlog -vlog01compat -work work +incdir+C:/Users/lmnjm/OneDrive/Documents/Grad\ School/Summer\ 2024/EE417\ Programmable\ Logic\ Devices/Lecture\ 11/Examples/FIFO\ Example {C:/Users/lmnjm/OneDrive/Documents/Grad School/Summer 2024/EE417 Programmable Logic Devices/Lecture 11/Examples/FIFO Example/FIFO_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  FIFO_tb

add wave *
view structure
view signals
run -all

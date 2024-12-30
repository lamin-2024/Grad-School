onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 20 -expand -group clock_input /Linear_Interpolator_tb/clock
add wave -noupdate -height 20 -expand -group reset_input /Linear_Interpolator_tb/reset
add wave -noupdate -height 20 -expand -group Data_in -radix symbolic /Linear_Interpolator_tb/Data_in
add wave -noupdate -height 20 -expand -group {buffer_temp storage} -radix decimal /Linear_Interpolator_tb/buffer
add wave -noupdate -height 20 -expand -group Data_out -radix decimal /Linear_Interpolator_tb/Data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 235
configure wave -valuecolwidth 146
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {964 ps}

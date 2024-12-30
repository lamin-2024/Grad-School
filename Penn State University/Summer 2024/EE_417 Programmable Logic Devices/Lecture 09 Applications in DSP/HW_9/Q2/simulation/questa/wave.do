onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 20 -expand -group clock_input /Differentiator_tb/clock
add wave -noupdate -height 20 -expand -group reset_input /Differentiator_tb/reset
add wave -noupdate -height 20 -expand -group hold_input /Differentiator_tb/hold
add wave -noupdate -height 20 -expand -group Data_in -radix decimal /Differentiator_tb/Data_in
add wave -noupdate -height 20 -expand -group {buffer_temp storage} -radix decimal /Differentiator_tb/buffer
add wave -noupdate -height 20 -expand -group Data_out -radix decimal /Differentiator_tb/Data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 191
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {8 ps}

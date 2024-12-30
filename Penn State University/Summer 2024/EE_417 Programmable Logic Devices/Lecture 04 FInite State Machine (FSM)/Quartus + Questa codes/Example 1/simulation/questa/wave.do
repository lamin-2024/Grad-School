onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -expand -group {output z_out} /Sequence_101_Detector_Mealy_TB/z_out
add wave -noupdate -height 30 -expand -group {input clk} /Sequence_101_Detector_Mealy_TB/clk
add wave -noupdate -height 30 -expand -group {input reset} /Sequence_101_Detector_Mealy_TB/reset
add wave -noupdate -height 30 -expand -group {input x_in} /Sequence_101_Detector_Mealy_TB/x_in
add wave -noupdate -height 30 -expand -group {internal probe-state} /Sequence_101_Detector_Mealy_TB/state
add wave -noupdate -height 30 -expand -group {internal probe-next_state} /Sequence_101_Detector_Mealy_TB/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 117
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
WaveRestoreZoom {0 ps} {256 ps}

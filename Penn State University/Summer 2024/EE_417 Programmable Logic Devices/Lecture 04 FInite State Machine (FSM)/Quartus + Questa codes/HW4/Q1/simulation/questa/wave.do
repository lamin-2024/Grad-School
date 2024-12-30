onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -expand -group {Output Z2} /Sequence_100_Detector_Mealy_TB/z2
add wave -noupdate -height 30 -expand -group {Output Z1} /Sequence_100_Detector_Mealy_TB/z1
add wave -noupdate -height 30 -expand -group {Input clk cycle} /Sequence_100_Detector_Mealy_TB/clk
add wave -noupdate -height 30 -expand -group {Input reset cycle} /Sequence_100_Detector_Mealy_TB/reset
add wave -noupdate -height 30 -expand -group {Input x_in} /Sequence_100_Detector_Mealy_TB/x_in
add wave -noupdate -height 30 -expand -group present_state -radix unsigned /Sequence_100_Detector_Mealy_TB/present_state
add wave -noupdate -height 30 -expand -group next_state /Sequence_100_Detector_Mealy_TB/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 296
configure wave -valuecolwidth 41
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
WaveRestoreZoom {0 ps} {260 ps}

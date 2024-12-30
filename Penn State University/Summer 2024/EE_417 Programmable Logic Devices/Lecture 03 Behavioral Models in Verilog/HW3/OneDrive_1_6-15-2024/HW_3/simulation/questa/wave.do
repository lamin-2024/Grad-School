onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary -expand /SevenSegDisplay2Digits_tb/V
add wave -noupdate -expand /SevenSegDisplay2Digits_tb/d1
add wave -noupdate -expand /SevenSegDisplay2Digits_tb/d0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {650 ps} {1650 ps}

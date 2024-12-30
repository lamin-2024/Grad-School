onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 20 -expand -group {clk _input} /code2421_upCounter_TB/clk
add wave -noupdate -height 30 -expand -group reset_input /code2421_upCounter_TB/reset
add wave -noupdate -height 20 -expand -group enable /code2421_upCounter_TB/enable
add wave -noupdate -height 30 -expand -group count_input -radix binary /code2421_upCounter_TB/count
add wave -noupdate -height 30 -expand -group upcount -radix binary /code2421_upCounter_TB/upcount
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 224
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
WaveRestoreZoom {0 ps} {175 ps}

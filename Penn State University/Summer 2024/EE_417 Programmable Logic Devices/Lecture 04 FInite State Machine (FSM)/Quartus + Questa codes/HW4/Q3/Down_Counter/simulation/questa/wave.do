onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -expand -group output_count -radix unsigned /code2421_downCounter_TB/count
add wave -noupdate -height 30 -expand -group reset_input /code2421_downCounter_TB/reset
add wave -noupdate -height 30 -expand -group enable_input /code2421_downCounter_TB/enable
add wave -noupdate -height 30 -expand -group clk_input /code2421_downCounter_TB/clk
add wave -noupdate -height 30 -expand -group present_state -radix unsigned /code2421_downCounter_TB/state
add wave -noupdate -height 30 -expand -group next_state /code2421_downCounter_TB/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 247
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
WaveRestoreZoom {246 ps} {390 ps}
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -expand -group clk_input /PAM4_to_NRZ_TB/clk
add wave -noupdate -height 30 -expand -group reset_input /PAM4_to_NRZ_TB/reset
add wave -noupdate -height 30 -expand -group PAM4_input -radix binary /PAM4_to_NRZ_TB/PAM4_in
add wave -noupdate -height 30 -expand -group NRZ_output /PAM4_to_NRZ_TB/NRZ_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 242
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
configure wave -timelineunits ps
update
WaveRestoreZoom {1 ps} {60 ps}

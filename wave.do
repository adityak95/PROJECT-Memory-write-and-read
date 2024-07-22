onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb/dut/clk
add wave -noupdate -radix unsigned /tb/dut/rst
add wave -noupdate -radix unsigned /tb/dut/wr_rd
add wave -noupdate -radix unsigned /tb/dut/ready
add wave -noupdate -radix unsigned /tb/dut/valid
add wave -noupdate -radix unsigned /tb/dut/addr
add wave -noupdate -radix hexadecimal /tb/dut/w_data
add wave -noupdate -radix hexadecimal /tb/dut/r_data
add wave -noupdate -radix unsigned /tb/dut/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {278 ps}

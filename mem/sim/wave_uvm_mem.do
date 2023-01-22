onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tbench_top/DUT/reset
add wave -noupdate /tbench_top/DUT/clk
add wave -noupdate /tbench_top/DUT/addr
add wave -noupdate /tbench_top/DUT/rd_en
add wave -noupdate /tbench_top/DUT/rdata
add wave -noupdate /tbench_top/DUT/wr_en
add wave -noupdate /tbench_top/DUT/wdata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 4} {1068210 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 248
configure wave -valuecolwidth 404
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ns} {3807 ns}
bookmark add wave bookmark0 {{768 ns} {898 ns}} 0
bookmark add wave bookmark1 {{3149314771 ps} {3149562853 ps}} 31
bookmark add wave bookmark2 {{2114 ns} {2526 ns}} 0
bookmark add wave bookmark3 {{1185431531 ps} {2158345221 ps}} 6
bookmark add wave bookmark4 {{132 ns} {1743 ns}} 0
bookmark add wave bookmark5 {{2823 ns} {3015 ns}} 0
bookmark add wave bookmark6 {{2545585067 ps} {2546304080 ps}} 3

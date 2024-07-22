vlib work
vlog str.v
vsim tb +testcase=Concurrent_fw_fr
#add wave -position insertpoint sim:/tb/dut/*
do wave.do
run -all

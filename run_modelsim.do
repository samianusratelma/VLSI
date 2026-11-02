# ModelSim / Questa :  File > Change Directory (to this folder), then in the
# transcript window type:   do run_modelsim.do
quit -sim
if {[file exists work]} { vdel -lib work -all }
vlib work
vcom -93 01_program_counter.vhd 02_program_rom.vhd 03_control_unit.vhd 04_alu.vhd 05_acc_z_reg.vhd 06_cpu_top.vhd 07_cpu_tb.vhd
vsim -voptargs=+acc work.cpu_tb
add wave -divider {Top level}
add wave -radix hexadecimal /cpu_tb/CLK
add wave -radix hexadecimal /cpu_tb/RESET
add wave -radix hexadecimal /cpu_tb/PC
add wave -radix hexadecimal /cpu_tb/uut/instr
add wave -radix hexadecimal /cpu_tb/Q
add wave -radix hexadecimal /cpu_tb/Z
add wave -divider {Control / ALU}
add wave -radix hexadecimal /cpu_tb/uut/alu_sel
add wave -radix hexadecimal /cpu_tb/uut/pc_load
add wave -radix hexadecimal /cpu_tb/uut/alu_res
run -all
wave zoom full

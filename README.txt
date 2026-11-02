Mini 8-bit Accumulator CPU  -  CSE 450 VLSI Lab Final Project (Spring 2026)
Student ID 22201106  ->  last digit 6  ->  SET 6
Instructions: LDI, ADD (mandatory) + SUB, JZ, SHL (assigned)   [no STA/LDR => no R register]

FILES (compile in this order)
 01_program_counter.vhd  4-bit PC (reset, +1, jump load)
 02_program_rom.vhd      16 x 12 ROM with the Appendix B Set 6 program
 03_control_unit.vhd     opcode decoder (ALU_SEL, ACC_WE, Z_WE, PC_LOAD)
 04_alu.vhd              LDI / ADD / SUB / SHL
 05_acc_z_reg.vhd        ACC (8-bit) + Z flag
 06_cpu_top.vhd          top level: CLK, RESET, Q[7:0], Z, PC[3:0]
 07_cpu_tb.vhd           self-checking testbench (prints the Appendix B table)
 cpu_all_in_one.vhd      all 7 files joined in one file (EDA Playground etc.)

HOW TO RUN
 GHDL     : ./run_ghdl.sh            (then: gtkwave cpu.vcd)
 ModelSim : do run_modelsim.do       (waveform opens automatically)
 Vivado   : add 01..06 as Design Sources, 07 as Simulation Source,
            set cpu_tb as top, Run Simulation > Behavioral, run 100 ns.
 EDA Playground : paste cpu_all_in_one.vhd into the single editor
            (or design.vhd = 01..06, testbench.vhd = 07), top = cpu_tb.

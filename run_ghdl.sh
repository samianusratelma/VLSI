#!/bin/bash
# Run with GHDL (Linux / macOS / WSL).  Then open the waveform with GTKWave.
set -e
mkdir -p work
ghdl -a --workdir=work 01_program_counter.vhd 02_program_rom.vhd 03_control_unit.vhd \
                       04_alu.vhd 05_acc_z_reg.vhd 06_cpu_top.vhd 07_cpu_tb.vhd
ghdl -e --workdir=work cpu_tb
ghdl -r --workdir=work cpu_tb --vcd=cpu.vcd
echo
echo "Waveform saved to cpu.vcd  ->  run:  gtkwave cpu.vcd"

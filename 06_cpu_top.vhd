-- =====================================================================
-- Part 6 : TOP LEVEL  - Mini 8-bit Accumulator CPU
-- ID: 22201106 | Set 6 : LDI, ADD, SUB, JZ, SHL
--
-- Ports : CLK, RESET (sync, active-high), Q[7:0] = ACC, Z flag, PC[3:0]
-- =====================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_top is
    port (
        CLK   : in  std_logic;
        RESET : in  std_logic;
        Q     : out std_logic_vector(7 downto 0);   -- ACC
        Z     : out std_logic;                      -- zero flag
        PC    : out std_logic_vector(3 downto 0)    -- program counter
    );
end entity cpu_top;

architecture structural of cpu_top is
    signal pc_s    : std_logic_vector(3 downto 0);
    signal instr   : std_logic_vector(11 downto 0);
    signal alu_sel : std_logic_vector(1 downto 0);
    signal acc_we  : std_logic;
    signal z_we    : std_logic;
    signal pc_load : std_logic;
    signal alu_res : std_logic_vector(7 downto 0);
    signal acc_s   : std_logic_vector(7 downto 0);
    signal z_s     : std_logic;
begin
    u_pc : entity work.program_counter
        port map (CLK => CLK, RESET => RESET, PC_LOAD => pc_load,
                  PC_ADDR => instr(3 downto 0), PC_OUT => pc_s);

    u_rom : entity work.program_rom
        port map (ADDR => pc_s, DATA => instr);

    u_ctrl : entity work.control_unit
        port map (OPCODE => instr(11 downto 8), Z_FLAG => z_s,
                  ALU_SEL => alu_sel, ACC_WE => acc_we,
                  Z_WE => z_we, PC_LOAD => pc_load);

    u_alu : entity work.alu
        port map (ACC_IN => acc_s, OPERAND => instr(7 downto 0),
                  ALU_SEL => alu_sel, RESULT => alu_res);

    u_reg : entity work.acc_z_reg
        port map (CLK => CLK, RESET => RESET, ACC_WE => acc_we,
                  Z_WE => z_we, D_IN => alu_res,
                  ACC_Q => acc_s, Z_FLAG => z_s);

    Q  <= acc_s;
    Z  <= z_s;
    PC <= pc_s;
end architecture structural;

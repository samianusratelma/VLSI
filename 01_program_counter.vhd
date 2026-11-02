-- =====================================================================
-- Part 1 : PROGRAM COUNTER (PC)
-- CSE 450 VLSI Lab | Final Project | Spring 2026
-- ID: 22201106 | Set 6 : LDI, ADD, SUB, JZ, SHL
--
-- 4-bit counter. On every rising edge:
--   RESET = 1  -> PC <= 0          (synchronous, highest priority)
--   PC_LOAD = 1-> PC <= PC_ADDR    (JZ taken)
--   otherwise  -> PC <= PC + 1
-- =====================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_counter is
    port (
        CLK     : in  std_logic;
        RESET   : in  std_logic;
        PC_LOAD : in  std_logic;                      -- 1 = jump (JZ taken)
        PC_ADDR : in  std_logic_vector(3 downto 0);   -- jump target = operand[3:0]
        PC_OUT  : out std_logic_vector(3 downto 0)
    );
end entity program_counter;

architecture rtl of program_counter is
    signal pc_reg : unsigned(3 downto 0) := (others => '0');
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                pc_reg <= (others => '0');
            elsif PC_LOAD = '1' then
                pc_reg <= unsigned(PC_ADDR);
            else
                pc_reg <= pc_reg + 1;
            end if;
        end if;
    end process;

    PC_OUT <= std_logic_vector(pc_reg);
end architecture rtl;

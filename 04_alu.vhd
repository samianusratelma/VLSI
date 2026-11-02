-- =====================================================================
-- Part 4 : ALU  (8-bit, combinational)
-- ID: 22201106 | Set 6 : LDI, ADD, SUB, JZ, SHL
--
--   00 : RESULT = OPERAND            (LDI)
--   01 : RESULT = ACC + OPERAND      (ADD, carry discarded)
--   10 : RESULT = ACC - OPERAND      (SUB, modulo 256)
--   11 : RESULT = ACC shifted left 1 (SHL, 0 enters LSB)
-- =====================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    port (
        ACC_IN  : in  std_logic_vector(7 downto 0);
        OPERAND : in  std_logic_vector(7 downto 0);
        ALU_SEL : in  std_logic_vector(1 downto 0);
        RESULT  : out std_logic_vector(7 downto 0)
    );
end entity alu;

architecture rtl of alu is
begin
    process (ACC_IN, OPERAND, ALU_SEL)
    begin
        case ALU_SEL is
            when "00" =>
                RESULT <= OPERAND;
            when "01" =>
                RESULT <= std_logic_vector(unsigned(ACC_IN) + unsigned(OPERAND));
            when "10" =>
                RESULT <= std_logic_vector(unsigned(ACC_IN) - unsigned(OPERAND));
            when others =>
                RESULT <= ACC_IN(6 downto 0) & '0';
        end case;
    end process;
end architecture rtl;

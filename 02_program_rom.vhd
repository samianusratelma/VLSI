-- =====================================================================
-- Part 2 : PROGRAM ROM  (16 x 12 bit, read combinationally by PC)
-- ID: 22201106 | Set 6 : LDI, ADD, SUB, JZ, SHL
--
-- instr[11:8] = opcode , instr[7:0] = operand
--   0: LDI 0x02 -> 0x102
--   1: SUB 0x01 -> 0x301
--   2: JZ  0x07 -> 0xC07
--   3: SUB 0x01 -> 0x301
--   4: JZ  0x07 -> 0xC07
--   5: ADD 0xAA -> 0x2AA
--   6: ADD 0xAA -> 0x2AA
--   7: LDI 0x21 -> 0x121
--   8: SHL      -> 0x800
--   9: ADD 0x01 -> 0x201
--  10-15: 0x000 (NOP)
-- =====================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_rom is
    port (
        ADDR : in  std_logic_vector(3 downto 0);
        DATA : out std_logic_vector(11 downto 0)
    );
end entity program_rom;

architecture rtl of program_rom is
    type rom_t is array (0 to 15) of std_logic_vector(11 downto 0);
    constant ROM : rom_t := (
        0      => x"102",   -- LDI 0x02
        1      => x"301",   -- SUB 0x01
        2      => x"C07",   -- JZ  0x07
        3      => x"301",   -- SUB 0x01
        4      => x"C07",   -- JZ  0x07
        5      => x"2AA",   -- ADD 0xAA
        6      => x"2AA",   -- ADD 0xAA
        7      => x"121",   -- LDI 0x21
        8      => x"800",   -- SHL
        9      => x"201",   -- ADD 0x01
        others => x"000"    -- NOP
    );
begin
    DATA <= ROM(to_integer(unsigned(ADDR)));
end architecture rtl;

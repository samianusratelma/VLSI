-- =====================================================================
-- Part 3 : CONTROL UNIT  (pure combinational decoder)
-- ID: 22201106 | Set 6 : LDI, ADD, SUB, JZ, SHL
--
-- Opcodes of Set 6:  LDI=0001  ADD=0010  SUB=0011  SHL=1000  JZ=1100
-- Any other opcode (incl. 0000) = NOP : nothing changes, PC <= PC + 1
--
-- ALU_SEL : 00 = pass operand (LDI)   01 = ACC + operand (ADD)
--           10 = ACC - operand (SUB)  11 = ACC << 1      (SHL)
-- =====================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    port (
        OPCODE  : in  std_logic_vector(3 downto 0);
        Z_FLAG  : in  std_logic;
        ALU_SEL : out std_logic_vector(1 downto 0);
        ACC_WE  : out std_logic;   -- write enable for ACC
        Z_WE    : out std_logic;   -- write enable for Z flag
        PC_LOAD : out std_logic    -- 1 = load jump address (JZ taken)
    );
end entity control_unit;

architecture rtl of control_unit is
    constant OP_LDI : std_logic_vector(3 downto 0) := "0001";
    constant OP_ADD : std_logic_vector(3 downto 0) := "0010";
    constant OP_SUB : std_logic_vector(3 downto 0) := "0011";
    constant OP_SHL : std_logic_vector(3 downto 0) := "1000";
    constant OP_JZ  : std_logic_vector(3 downto 0) := "1100";
begin
    process (OPCODE, Z_FLAG)
    begin
        -- default = NOP
        ALU_SEL <= "00";
        ACC_WE  <= '0';
        Z_WE    <= '0';
        PC_LOAD <= '0';

        case OPCODE is
            when OP_LDI =>
                ALU_SEL <= "00"; ACC_WE <= '1'; Z_WE <= '1';
            when OP_ADD =>
                ALU_SEL <= "01"; ACC_WE <= '1'; Z_WE <= '1';
            when OP_SUB =>
                ALU_SEL <= "10"; ACC_WE <= '1'; Z_WE <= '1';
            when OP_SHL =>
                ALU_SEL <= "11"; ACC_WE <= '1'; Z_WE <= '1';
            when OP_JZ  =>
                PC_LOAD <= Z_FLAG;          -- jump only if Z = 1, flags unchanged
            when others =>
                null;                        -- NOP
        end case;
    end process;
end architecture rtl;

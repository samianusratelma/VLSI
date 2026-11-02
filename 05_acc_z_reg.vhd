-- =====================================================================
-- Part 5 : ACC and Z-FLAG registers
-- ID: 22201106 | Set 6 : LDI, ADD, SUB, JZ, SHL
--
-- (Set 6 has no STA/LDR, so the holding register R is NOT required.)
-- RESET = 1 at rising edge : ACC <= 0x00 , Z <= 1   (priority)
-- ACC_WE = 1               : ACC <= D_IN
-- Z_WE   = 1               : Z   <= 1 if D_IN = 0x00 else 0
-- =====================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acc_z_reg is
    port (
        CLK    : in  std_logic;
        RESET  : in  std_logic;
        ACC_WE : in  std_logic;
        Z_WE   : in  std_logic;
        D_IN   : in  std_logic_vector(7 downto 0);   -- ALU result
        ACC_Q  : out std_logic_vector(7 downto 0);
        Z_FLAG : out std_logic
    );
end entity acc_z_reg;

architecture rtl of acc_z_reg is
    signal acc_reg : std_logic_vector(7 downto 0) := (others => '0');
    signal z_reg   : std_logic := '1';
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                acc_reg <= (others => '0');
                z_reg   <= '1';
            else
                if ACC_WE = '1' then
                    acc_reg <= D_IN;
                end if;
                if Z_WE = '1' then
                    if D_IN = "00000000" then
                        z_reg <= '1';
                    else
                        z_reg <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;

    ACC_Q  <= acc_reg;
    Z_FLAG <= z_reg;
end architecture rtl;

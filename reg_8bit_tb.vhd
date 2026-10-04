--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:49:47 10/04/2026
-- Design Name:   
-- Module Name:   /home/ise/Register8bit/reg_8bit_tb.vhd
-- Project Name:  Register8bit
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: reg_8bit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY reg_8bit_tb IS
END reg_8bit_tb;
 
ARCHITECTURE behavior OF reg_8bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg_8bit
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         LOAD : IN  std_logic;
         D : IN  std_logic_vector(7 downto 0);
         Q : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal LOAD : std_logic := '0';
   signal D : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Q : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg_8bit PORT MAP (
          CLK => CLK,
          RESET => RESET,
          LOAD => LOAD,
          D => D,
          Q => Q
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 
	RESET <='1';
	lOAD <= '0';
	D <="00000000";
	wait for 20 ns;
	
	RESET <='0';
	lOAD <= '1';
	D <="10101010";
	wait for 20 ns;
	
	lOAD <= '0';
	wait for 20 ns;
	
	lOAD <= '1';
	D <="11110000";
	wait for 20 ns;
	
	lOAD <= '0';
	wait for 20 ns;
	
	

   wait;
   end process;

END;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity reg_8bit is
    port (CLK   : in  STD_LOGIC;
	       RESET : in  STD_LOGIC;
	       LOAD  : in  STD_LOGIC;
	       D     : in  STD_LOGIC_VECTOR (7 downto 0) ;
	       Q     : out STD_LOGIC_VECTOR (7 downto 0));
end  reg_8bit;
architecture Behavioral of reg_8bit is
  signal Q_int :STD_LOGIC_VECTOR(7 downto 0) ;
begin 
     
     process(CLK)
     begin
          if rising_edge(CLK) then
              if RESET = '1' then
                  Q_int <= "00000000";
               elsif LOAD = '1' then
                   Q_int <= D;
               end if;
          end if;
      end process;
      Q <= Q_int;
end Behavioral;		
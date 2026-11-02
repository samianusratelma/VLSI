-- =====================================================================
-- Part 7 : TESTBENCH (self-checking)
-- ID: 22201106 | Set 6 : LDI, ADD, SUB, JZ, SHL
--
-- * generates a 10 ns clock
-- * applies RESET for exactly one rising edge
-- * runs 8 instructions (one clock each) = Appendix B Set 6
-- * after every edge it prints one table row and compares ACC, Z and
--   next-PC with the Appendix B expected values -> PASS / FAIL
-- =====================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity cpu_tb is
end entity cpu_tb;

architecture sim of cpu_tb is
    signal CLK   : std_logic := '0';
    signal RESET : std_logic := '1';
    signal Q     : std_logic_vector(7 downto 0);
    signal Z     : std_logic;
    signal PC    : std_logic_vector(3 downto 0);
    signal done  : boolean := false;

    constant CLK_PERIOD : time := 10 ns;

    -- Appendix B, Set 6.  Index 0 = reset row, 1..8 = cycles
    type int_arr is array (0 to 8) of integer;
    constant EXP_PC_EXEC : int_arr := (0, 0, 1, 2, 3, 4, 7,  8,  9);
    constant EXP_ACC     : int_arr := (0, 2, 1, 1, 0, 0, 33, 66, 67);
    constant EXP_Z       : int_arr := (1, 0, 0, 0, 1, 1, 0,  0,  0);
    constant EXP_NEXT_PC : int_arr := (0, 1, 2, 3, 4, 7, 8,  9,  10);

    ------------------------------------------------------------------
    -- helper functions (printing)
    ------------------------------------------------------------------
    function pad(s : string; n : natural) return string is
        variable r : string(1 to n) := (others => ' ');
    begin
        r(1 to s'length) := s;
        return r;
    end function;

    function to_hex2(v : std_logic_vector(7 downto 0)) return string is
        constant H : string(1 to 16) := "0123456789ABCDEF";
        variable r : string(1 to 2);
    begin
        r(1) := H(to_integer(unsigned(v(7 downto 4))) + 1);
        r(2) := H(to_integer(unsigned(v(3 downto 0))) + 1);
        return r;
    end function;

    function to_bin8(v : std_logic_vector(7 downto 0)) return string is
        variable r : string(1 to 8);
    begin
        for k in 0 to 7 loop
            if v(7 - k) = '1' then r(k + 1) := '1'; else r(k + 1) := '0'; end if;
        end loop;
        return r;
    end function;

    function bitc(s : std_logic) return string is
    begin
        if s = '1' then return "1"; elsif s = '0' then return "0"; else return "X"; end if;
    end function;

    function instr_name(i : integer) return string is
    begin
        case i is
            when 0      => return "RESET = 1";
            when 1      => return "LDI 0x02";
            when 2      => return "SUB 0x01";
            when 3      => return "JZ 0x07 (not taken)";
            when 4      => return "SUB 0x01";
            when 5      => return "JZ 0x07 (taken)";
            when 6      => return "LDI 0x21";
            when 7      => return "SHL";
            when 8      => return "ADD 0x01";
            when others => return "?";
        end case;
    end function;

begin
    ------------------------------------------------------------------
    -- Device under test
    ------------------------------------------------------------------
    uut : entity work.cpu_top
        port map (CLK => CLK, RESET => RESET, Q => Q, Z => Z, PC => PC);

    ------------------------------------------------------------------
    -- Clock generator (stops when the test is finished)
    ------------------------------------------------------------------
    clk_gen : process
    begin
        while not done loop
            CLK <= '0'; wait for CLK_PERIOD / 2;
            CLK <= '1'; wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    ------------------------------------------------------------------
    -- Stimulus + checker
    ------------------------------------------------------------------
    stim : process
        variable l       : line;
        variable errors  : integer := 0;
        variable pc_exec : std_logic_vector(3 downto 0);

        procedure check_row(i : in integer; pcx : in std_logic_vector(3 downto 0)) is
            variable ln : line;
            variable ok : boolean := true;
            variable zx : std_logic;
        begin
            if EXP_Z(i) = 1 then zx := '1'; else zx := '0'; end if;

            if Q  /= std_logic_vector(to_unsigned(EXP_ACC(i), 8))     then ok := false; end if;
            if Z  /= zx                                               then ok := false; end if;
            if PC /= std_logic_vector(to_unsigned(EXP_NEXT_PC(i), 4)) then ok := false; end if;
            if i > 0 then
                if pcx /= std_logic_vector(to_unsigned(EXP_PC_EXEC(i), 4)) then ok := false; end if;
            end if;
            if not ok then errors := errors + 1; end if;

            write(ln, pad(integer'image(i), 7));
            if i = 0 then
                write(ln, pad("-", 10));
            else
                write(ln, pad(integer'image(to_integer(unsigned(pcx))), 10));
            end if;
            write(ln, pad(instr_name(i), 22));
            write(ln, pad("0x" & to_hex2(Q), 7));
            write(ln, pad(bitc(Z), 4));
            write(ln, pad(to_bin8(Q), 11));
            write(ln, pad(integer'image(to_integer(unsigned(PC))), 9));
            if ok then write(ln, string'("PASS")); else write(ln, string'("FAIL")); end if;
            writeline(output, ln);
        end procedure;

    begin
        write(l, string'("=============================================================================="));
        writeline(output, l);
        write(l, string'(" Mini 8-bit Accumulator CPU | ID 22201106 | Set 6 : LDI, ADD, SUB, JZ, SHL"));
        writeline(output, l);
        write(l, string'("=============================================================================="));
        writeline(output, l);
        write(l, string'("Cycle  PC(exec)  Instruction           ACC    Z   ACC(bin)   Next PC  Check"));
        writeline(output, l);
        write(l, string'("------------------------------------------------------------------------------"));
        writeline(output, l);

        -- Cycle 0 : RESET = 1 for exactly one rising edge
        RESET <= '1';
        wait until rising_edge(CLK);
        wait for 1 ns;
        check_row(0, PC);
        RESET <= '0';

        -- Cycles 1..8 : one instruction per clock
        for i in 1 to 8 loop
            pc_exec := PC;                  -- address being executed
            wait until rising_edge(CLK);
            wait for 1 ns;                  -- let outputs settle, then sample
            check_row(i, pc_exec);
        end loop;

        write(l, string'("------------------------------------------------------------------------------"));
        writeline(output, l);
        if errors = 0 then
            write(l, string'("RESULT: all 9 rows match Appendix B (Set 6)  ->  TEST PASSED"));
        else
            write(l, string'("RESULT: MISMATCHES FOUND = ") & integer'image(errors) & string'("  ->  TEST FAILED"));
        end if;
        writeline(output, l);

        wait for 4 ns;
        done <= true;      -- stops the clock, simulation ends
        wait;
    end process;
end architecture sim;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;



entity statemachine is
    Port ( 
           EN : in STD_LOGIC;
           clear : in STD_LOGIC;
           updn : in STD_LOGIC;
           clk : in STD_LOGIC;
           mm : in STD_LOGIC;
           Dnext : out STD_LOGIC_VECTOR(2 downto 0));
end statemachine;

architecture Behavioral of statemachine is

type state is (s0, s1, s2, s3, s4, s5, s6);
signal scur, snext : state;
begin
--state <= en & updn;
next_state : process (EN, updn, scur)
    begin
        if(en='0') then
            snext <= scur;
    elsif(updn='0') then
    Case (scur) IS
        when s0 =>
            snext <= s6;
        when s1 =>
            snext <= s0;
        when s2 =>
            snext <= s1;
        when s3 =>
            snext <= s2;
        when s4 =>
            snext <= s3;
        when s5 =>
            snext <= s4;
        when s6 =>
            snext <= s5;
        end case;
    elsif (updn='1') then
    Case (scur) IS
        when s0 =>
            snext <= s1;
        when s1 =>
            snext <= s2;
        when s2 =>
            snext <= s3;
        when s3 =>
            snext <= s4;
        when s4 =>
            snext <= s5;
        when s5 =>
            snext <= s6;
        when s6 =>
            snext <= s0;
        end case;
    end if;
end process;

state_reg : process(clk, clear)
    begin
        if (clk'event and clk = '1') then
            scur <= snext;
        end if;
        if(clear = '1') then
            scur <= s0;
        end if;
end process;


    Dnext <= "000" when (scur = s0 and mm = '1') or (mm = '0' and scur = s0 and (clear = '1' or en = '0')) or (mm = '0' and en = '1' and ((scur = s6 and updn = '1') or (scur = s1 and updn = '0'))) else
             "001" when (scur = s1 and mm = '1') or (mm = '0' and scur = s1 and (clear = '1' or en = '0')) or (mm = '0' and en = '1' and ((scur = s0 and updn = '1') or (scur = s2 and updn = '0'))) else
             "010" when (scur = s2 and mm = '1') or (mm = '0' and scur = s2 and (clear = '1' or en = '0')) or (mm = '0' and en = '1' and ((scur = s1 and updn = '1') or (scur = s3 and updn = '0'))) else
             "011" when (scur = s3 and mm = '1') or (mm = '0' and scur = s3 and (clear = '1' or en = '0')) or (mm = '0' and en = '1' and ((scur = s2 and updn = '1') or (scur = s4 and updn = '0'))) else
             "100" when (scur = s4 and mm = '1') or (mm = '0' and scur = s4 and (clear = '1' or en = '0')) or (mm = '0' and en = '1' and ((scur = s3 and updn = '1') or (scur = s5 and updn = '0'))) else
             "101" when (scur = s5 and mm = '1') or (mm = '0' and scur = s5 and (clear = '1' or en = '0')) or (mm = '0' and en = '1' and ((scur = s4 and updn = '1') or (scur = s6 and updn = '0'))) else
             "110" when (scur = s6 and mm = '1') or (mm = '0' and scur = s6 and (clear = '1' or en = '0')) or (mm = '0' and en = '1' and ((scur = s5 and updn = '1') or (scur = s0 and updn = '0'))) else
             "000";
end Behavioral;

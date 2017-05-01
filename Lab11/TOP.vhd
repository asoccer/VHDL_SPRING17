
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP is
  Port (clk : in STD_LOGIC;
        EN : in STD_LOGIC;
        clear : in STD_LOGIC;
        updn : in STD_LOGIC;
        mm : in STD_LOGIC;
        
        Dout : out STD_LOGIC_VECTOR(2 downto 0));
end TOP;

architecture Behavioral of TOP is

signal Dnext : STD_LOGIC_VECTOR(2 downto 0);


component statemachine
    Port ( 
           EN : in STD_LOGIC;
           clear : in STD_LOGIC;
           updn : in STD_LOGIC;
           clk : in STD_LOGIC;
           mm : in STD_LOGIC;
           Dnext : out STD_LOGIC_VECTOR(2 downto 0));
end component;

begin
state : statemachine port map(EN => EN, clear => clear, updn => updn, clk => clk, mm => mm, Dnext => Dnext);

Dout <= Dnext;
end Behavioral;

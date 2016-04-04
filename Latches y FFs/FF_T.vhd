
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_T is
    Port ( T : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           NQ : out  STD_LOGIC);
end FF_T;

architecture Behavioral of FF_T is

signal J_aux:STD_LOGIC;
signal K_aux:STD_LOGIC;

COMPONENT FF_JK
	PORT(
		clk : IN std_logic;
		J : IN std_logic;
		K : IN std_logic;
		Q : OUT std_logic;
		NQ : OUT std_logic
		);
	END COMPONENT;


	
begin
	Inst_FF_JK: FF_JK PORT MAP(
		CLK => clk,
		J => T,
		K => T,
		Q => Q,
		NQ => NQ
	);
	
end Behavioral;


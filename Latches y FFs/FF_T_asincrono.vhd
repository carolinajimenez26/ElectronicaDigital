
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_T_asincrono is
    Port ( T : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PRE : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           NQ : out  STD_LOGIC);
end FF_T_asincrono;

architecture Behavioral of FF_T_asincrono is

signal Q_aux : std_logic:='0';
signal NQ_aux : std_logic:='1';

COMPONENT FF_T
	PORT(
		T : IN std_logic;
		CLK : IN std_logic;          
		Q : OUT std_logic;
		NQ : OUT std_logic
		);
	END COMPONENT;

begin

Inst_FF_T: FF_T PORT MAP(
				T => T,
				Clk => CLK,
				Q => Q,
				NQ => NQ
			);


process (PRE,CLR)
begin
	
	if(PRE = '0') then
		Q_aux <= '1';
		NQ <= '0';
	else
		if( CLR = '0') then
			Q_aux <= '0';
			NQ_aux <= '1';
		--else FFT
			
		end if;
	end if;
	
end process;

Q <= Q_aux;
NQ <= NQ_aux;

end Behavioral;


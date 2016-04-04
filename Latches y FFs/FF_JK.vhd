
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_JK is
    Port ( clk : in  STD_LOGIC;
           J : in  STD_LOGIC;
           K : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           NQ : out  STD_LOGIC);
end FF_JK;

architecture Behavioral of FF_JK is

signal Q_aux : std_logic:='0';
signal NQ_aux : std_logic:='1';
signal A : std_logic;
signal B : std_logic;

begin

process (clk)
	begin
		if(CLK'event and CLK='1') then
			if(J = '0' and K = '1') then
				Q_aux <= '0';
				NQ_aux <= '1';
			else 
				if(J = '1' and K = '0') then
					Q_aux <= '1';
					NQ_aux <= '0';
				else 
					if(J = '1' and K = '1') then
						Q_aux <= NQ_aux;
						NQ_aux <= Q_aux;
					end if;
				end if;
			end if;
		end if;
	end process;
	
Q <= Q_aux;
NQ <= NQ_aux;	

end Behavioral;


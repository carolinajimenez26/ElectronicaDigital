
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity contadordir is
    Port ( pwait_in : in  STD_LOGIC;
           address_out : out  STD_LOGIC_VECTOR (22 downto 0));
end contadordir;

architecture Behavioral of contadordir is

signal ready: std_logic:='0';
signal address : std_logic_vector(22 downto 0):=(others=>'0');


begin
	
	process(pwait_in)
	begin
		if(pwait_in='1')then
			if(ready='1')then
				if(address>=307199)then
					address<=(others=>'0');
				else
					address <= address+1;
				end if;			
			end if;
			ready<='0';
		else
			ready<='1';
		end if;
	end process;
	
	address_out <= address;

end Behavioral;


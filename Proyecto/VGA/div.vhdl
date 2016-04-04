--Divisor de Frecuencia de UART

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Div_F_UART is
    Port ( CLK : in  STD_LOGIC;
           Div_UART : out  STD_LOGIC);
end Div_F_UART;


architecture Div_Frecuencia of Div_F_UART is
	signal tmp: std_logic_vector(1 downto 0):=(others => '0');
begin
	process (CLK)
	begin
		if(CLK'event and CLK='1') then
			if(tmp >= 1) then
				tmp <= "00";
				Div_UART <= '1';
			else
		  		tmp <= tmp + 1;
				Div_UART <='0';
			end if;
		end if;
	end process;
end Div_Frecuencia;


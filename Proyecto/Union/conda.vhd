library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;



entity conda is
    Port ( pwai : in  STD_LOGIC;
           direcc : out  STD_LOGIC_VECTOR (22 downto 0)
			  ready : out  STD_LOGIC
			  );
end conda;

architecture Behavioral of conda is

signal address_out : std_logic_vector(22 downto 0);
constant max: integer := 307199;   --50000000--
signal contador: integer range 0 to max;

begin

process(pwai)
begin
	if pwai'event and pwai='1' and pwai'last_value = '0' then
			if contador < max then
				ready <= '0';
				contador <= contador + 1;
			end if;
			
			if contador >= max then
				ready <= '1'
				contador <= 0;
			end if;
	end if;
end process;

direcc <= conv_std_logic_vector(contador, 23);
	


end Behavioral;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Transmitter is
    Port ( div  : in STD_LOGIC;--divisor de frecuencia
				clk : in STD_LOGIC;
				data: in STD_LOGIC_VECTOR (7 downto 0);--datos que serán enviados
				send : in STD_LOGIC;--
				Line : out  STD_LOGIC
			);--salida, manda dato por dato
	 
end Transmitter;

architecture Behavioral of Transmitter is


signal estado : STD_LOGIC_VECTOR (4 downto 0):="00000";--son 8 estados totales, 2^3=8
signal aux : STD_LOGIC;--

begin

process(div,data,send,estado,aux,clk)
begin

if(rising_edge(clk)) then 
	if (div ='1') then
		case estado is 
		
		when "00000" => if (send='1') then --bit de inicio debe ser 1 porque es el que termina en el Receive
								aux <= '0';
								estado<="00001";--cambia de estado						
							--else --todavía no puede enviar
								--aux<='1';
							end if;
							
		when "00001" => aux<=data(7);
							estado<="00010";
									
		when "00010" => aux<=data(6);
							estado<="00011";
							
		
		when "00011" => aux<=data(5);
							estado<="00100";
		
		
		when "00100" => aux<=data(4);
							estado<="00101";
							
		
		when "00101" => aux<=data(3);
							estado<="00110";
							
		
		when "00110" => aux<=data(2);
							estado<="00111";
							
		
		when "00111" => aux<=data(1);
							estado<="01000";
							
		when "01000" => aux<=data(0);
							estado<="01001";
							
		when "01001" => aux<='1'; --bit de parada
							estado<="00000";
							
		when OTHERS => estado <= "00000";	

		end case;
	end if;
end if;
line<=aux;

end process;	

end Behavioral;


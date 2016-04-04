library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity registro is
		Port ( 
			Ver,Guardar,Clean : inout STD_LOGIC;
			Reloj : in std_logic;
			Entrada : in STD_LOGIC_VECTOR (2 downto 0);
			Salida : out STD_LOGIC_VECTOR (2 downto 0));
end registro;

architecture Behavioral of registro is

Signal Registro : std_logic_vector (2 downto 0);
Signal Contador : integer := 0;


begin
process(reloj)
begin
				if reloj'event and reloj = '1' then
					contador <= contador + 1;
					if contador = 1 then
						if guardar = '1' then
							Registro <= Entrada;
						end if;
						if ver = '1' then
							Salida <= Registro;
						end if;
						if Clean = '1' then
							Registro <= "000";
							Salida <= Registro;
						end if;
						contador <= 0;
					end if;
				end if;
end process;
end Behavioral; 
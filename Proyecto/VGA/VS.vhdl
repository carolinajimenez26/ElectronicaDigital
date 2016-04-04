library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_1164.ALL;

entity VS is
    Port ( clk : in  STD_LOGIC;
           div : in  STD_LOGIC;
			  disp_vs : out  STD_LOGIC;
			  salida : out  STD_LOGIC;
           vs : out  STD_LOGIC);
end VS;

architecture Behavioral of VS is

signal tmpPW: std_logic_vector(10 downto 0):=(others => '0');--2^11 para representar el 1600
signal t_disp: std_logic_vector(18 downto 0):=(others => '0');--2^19 para representar el 384000
signal tmpBp: std_logic_vector(14 downto 0):=(others => '0');--2^15 para representar el 23200
signal tmpFp: std_logic_vector(12 downto 0):=(others => '0');--2^13 para representar el 8000

begin

process (clk,div)
	
	begin
		if(CLK'event and CLK='1') then
			if(div='1') then
				
				if(tmpPW < 1600) then --mientras tmpPW no haya terminado de contar
						vs <= '0'; 
						salida <= '0';
						disp_vs <= '0';
						tmpPW <= tmpPW + 1;
						
					--cuando tmpPW haya termiando de contar
					else
						if(tmpBp < 23200) then --back porch
							vs <= '1'; 
							disp_vs <= '0';
							tmpBp <= tmpBp + 1; --sigue contando
						else
							if(t_disp < 384000) then --tiempo de display
								disp_vs <= '1';--display
								vs <= '1'; 
								t_disp <= t_disp + 1;
							else 
								if(tmpFp < 8000) then --Front porch
									vs <= '1'; 
									disp_vs <= '0';
									tmpFp <= tmpFp + 1;
									if(tmpFp = 8000 - 1) then
										salida <= '1';
										tmpPW <= "00000000000";
										tmpBp <= "000000000000000";
										t_disp <= "0000000000000000000";
										tmpFp <= "0000000000000";
									end if;
								end if;
							end if;
						end if;
					end if;
			end if;
		end if;
	end process;

end Behavioral;

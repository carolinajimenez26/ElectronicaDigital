
library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_1164.ALL;


entity HS is
    Port ( clk : in  STD_LOGIC;
           div : in  STD_LOGIC;
			  vs : in  STD_LOGIC; --para que se estabilice la señal
			  disp_hs : out  STD_LOGIC;
           hs : out  STD_LOGIC);
end HS;

architecture Behavioral of HS is

signal tmpPW: std_logic_vector(6 downto 0):=(others => '0');--2^7 para representar el 96
signal t_disp: std_logic_vector(9 downto 0):=(others => '0');--2^10 para representar el 640
signal tmpBp: std_logic_vector(5 downto 0):=(others => '0');--2^6 para representar el 48
signal tmpFp: std_logic_vector(4 downto 0):=(others => '0');--2^4 para representar el 16

begin

process (div,clk)
	
	begin
		if(CLK'event and CLK='1') then
			if(div='1') then
				--if(vs = '0') then
					if(tmpPW < 96) then --mientras tmpPW no haya terminado de contar
						hs <= '0'; 
						disp_hs <= '0';
						tmpPW <= tmpPW + 1;
					--cuando tmpPW haya termiando de contar
					else
						if(tmpBp < 48) then --back porch
							hs <= '1'; 
							disp_hs <= '0';
							tmpBp <= tmpBp + 1; --sigue contando
						else
							--tmpBp <= "000000"; --ya no está en back porch
							if(t_disp < 640) then --tiempo de display
								disp_hs <= '1';--display
								hs <= '1'; 
								t_disp <= t_disp + 1;
							else 
								if(tmpFp < 16) then --Front porch
									hs <= '1'; 
									disp_hs <= '0';
									tmpFp <= tmpFp + 1;
									if(tmpFp = 15) then 
										tmpPW <= "0000000";
										tmpBp <= "000000";
										t_disp <= "0000000000";
										tmpFp <= "00000";
									end if;
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
end process;


end Behavioral;

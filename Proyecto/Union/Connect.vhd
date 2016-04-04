library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity Connect is
	Port(clkA : in STD_LOGIC;
		  clkB: in STD_LOGIC;
		  data_outA : out STD_LOGIC_VECTOR (7 downto 0);
		  data_outB : out STD_LOGIC_VECTOR (7 downto 0);
		  pdb : inout STD_LOGIC_VECTOR (7 downto 0);
		  astb     : in std_logic;
        dstb     : in std_logic;
        pwr     : in std_logic;
		  rgSwt    : in std_logic_vector(7 downto 0);
		  pwait_out: out std_logic;
		  address_out : out std_logic_vector(22 downto 0);
        rgBtn    : in std_logic_vector(4 downto 0)
		  );

end Connect;

COMPONENT dpimref
	PORT(mclk     : in std_logic;
        pdb        : inout std_logic_vector(7 downto 0);
        astb     : in std_logic;
        dstb     : in std_logic;
        pwr     : in std_logic;
        pwait     : out std_logic;
        rgLed    : out std_logic_vector(7 downto 0);
        rgSwt    : in std_logic_vector(7 downto 0);
        rgBtn    : in std_logic_vector(4 downto 0)
		  );
	END COMPONENT;

signal enable: std_logic :='1';
signal address : std_logic_vector(22 downto 0):="00000000";
signal pwait: std_logic;
signal rgLed: std_logic_vector(7 downto 0):="00000000";
--signal cont: integer:=0;
signal ready: std_logic:='0';

begin


	Inst_API: dpimref PORT MAP(mclk => clkA,
										pdb => pdb,
										astb => astb,
										dstb => dstb,
										pwr => pwr,
										pwait => pwait,
										rgLed => rgLed,
										rgSwt => rgSwt,
										rgBtn => rgBtn
										);									
	pwait_out <= pwait;
	address_out <= address;
	
	process(pwait)
	begin
		if(pwait='1')then
			if(ready='1')then
				if(address>=8)then
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
	
										

		

end Behavioral;


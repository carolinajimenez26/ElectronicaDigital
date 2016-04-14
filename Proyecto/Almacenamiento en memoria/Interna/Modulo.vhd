
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Modulo is
    Port ( CLK : in  STD_LOGIC;
           WEA : in  STD_LOGIC;
           WEB : in  STD_LOGIC;
           ENA : in  STD_LOGIC;
           ENB : in  STD_LOGIC;
           ADDRA : in  STD_LOGIC_VECTOR (2 downto 0);
           ADDRB : in  STD_LOGIC_VECTOR (5 downto 0);
           DIA : in  STD_LOGIC_VECTOR (7 downto 0);
           DIB : in  STD_LOGIC_VECTOR (7 downto 0);
           DOA : out  STD_LOGIC_VECTOR (7 downto 0)
           DOB : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end Modulo;

architecture Behavioral of Modulo is

COMPONENT rams_01
	PORT(
		CLKA : IN std_logic;
		WEA : IN std_logic;
		ENA : IN std_logic;
		ADDRA : IN std_logic_vector(7 downto 0);
		DIA : IN std_logic_vector(7 downto 0);
		CLKB : IN std_logic;
		WEB : IN std_logic;
		ENB : IN std_logic;
		ADDRB : IN std_logic_vector(7 downto 0);
		DIB : IN std_logic_vector(7 downto 0);          
		DOA : OUT std_logic_vector(7 downto 0);
		DOB : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

begin

	Inst_rams_01: rams_01 PORT MAP(
		CLKA => CLK,
		WEA => WEA,
		ENA => ENA,
		ADDRA => ADDRA,
		DIA => DIA,
		DOA => DOA
		CLKB => CLK,
		WEB => WEB,
		ENB => ENB,
		ADDRB => ADDRB,
		DIB => DIB,
		DOB => DOB
	);

end Behavioral;


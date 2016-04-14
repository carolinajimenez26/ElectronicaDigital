--BRAM MEMORIA INTERNA DUAL PORT, 512bits (2⁶ direcciones de memoria x 8 bits de datos)
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_01 is
    port (CLKA  : in std_logic;
          WEA   : in std_logic;
          ENA   : in std_logic;
          ADDRA : in std_logic_vector(7 downto 0);
          DIA   : in std_logic_vector(7 downto 0);
          DOA   : out std_logic_vector(7 downto 0);
			 
			 CLKB  : in std_logic;
          WEB   : in std_logic;
          ENB   : in std_logic;
          ADDRB : in std_logic_vector(7 downto 0);
          DIB   : in std_logic_vector(7 downto 0);
          DOB   : out std_logic_vector(7 downto 0)
			 );
			 
end rams_01;

architecture syn of rams_01 is

	 type ram_type is array (7 downto 0) of std_logic_vector (7 downto 0); --2⁶ x 8bits
			
			--signal RAM: ram_type;
	 shared variable RAM: ram_type := ("00000000",
			"00000000",
			"00000000",
			"00000000",
			"00000000",
			"00000000",
			"00000000",
			"00000000");
	 
begin
 
    process (CLKA)
    begin
        if CLKA'event and CLKA = '1' then
            if ENA = '1' then
                if WEA = '1' then
                    RAM(conv_integer(ADDRA)) := DIA;--escribe en la memoria en esa dirección
                end if;
                DOA <= RAM(conv_integer(ADDRA)) ;--muestra los datos que acaba de ingresar
            end if;
        end if;
    end process;
	 
	 process (CLKB)
    begin
        if CLKB'event and CLKB = '1' then
            if ENB = '1' then
                if WEB = '1' then
                    RAM(conv_integer(ADDRB)) := DIB;
                end if;
                DOB <= RAM(conv_integer(ADDRB)) ;
            end if;
        end if;
    end process;

end syn;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity casteador is
    Port ( vector : in  STD_LOGIC_VECTOR (15 downto 0);
           salida : out  STD_LOGIC_VECTOR (2 downto 0));
end casteador;

architecture Behavioral of casteador is

signal V : std_logic_vector(5 downto 0); 

begin

V(5 downto 0) <= vector(15 downto 10);
--Se debe tener un registro que vaya enviando datos al VGA cada que sea necesario



--De 16 datos nos interesan unicamente 6, es decir, dos pixeles
--y esos 6 datos los dividimos en 2, para tener el pixel individual
--cada bit del pixel se pasa a R, a G y a B

end Behavioral;


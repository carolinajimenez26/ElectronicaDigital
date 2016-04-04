library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity vga_hab is
    Port ( TD_vga : in  STD_LOGIC;
           selec : in  STD_LOGIC;--we de memoria
           hab : out  STD_LOGIC);
end vga_hab;

architecture Behavioral of vga_hab is

begin

hab <= not(selec) and TD_vga;


end Behavioral;


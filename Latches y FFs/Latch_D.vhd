
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Latch is
    Port ( D : in  STD_LOGIC;
           E : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           QN : out  STD_LOGIC);
end Latch;

architecture Behavioral of Latch is

signal C1,C2,C3,C4 : std_logic := '0';

begin

C1 <= D nand E;
C2 <= (not D) nand E;
C3 <= C1 nand C4;
C4 <= C2 nand C3;
Q <= C3;
QN <= C4;


end Behavioral;
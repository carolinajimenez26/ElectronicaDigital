--Este es el que se corrigió en clase
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Latch_SRE_bajo is
    Port ( S : in  STD_LOGIC;
           E : in  STD_LOGIC;
           R : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           NQ : out  STD_LOGIC);
end Latch_SRE_bajo;

architecture Behavioral of Latch_SRE_bajo is

signal Q_aux : std_logic;
signal NQ_aux : std_logic;
signal A : std_logic;
signal B : std_logic;

begin

A <= S nor E;
B <= R nor E;
Q_aux <= A nor NQ_aux;
NQ_aux <= B nor Q_aux;

NQ <= NQ_aux;
Q <= Q_aux;

end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Latch_SR_bajo is
    Port ( S : in  STD_LOGIC;
           R : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           NQ : out  STD_LOGIC);
end Latch_SR_bajo;

architecture Behavioral of Latch_SR_bajo is

signal Q_aux : std_logic;
signal NQ_aux : std_logic;

begin

Q_aux <= S nand NQ_aux;
NQ_aux <= R nand Q_aux;

Q <= Q_aux;
NQ <= NQ_aux;

end Behavioral;



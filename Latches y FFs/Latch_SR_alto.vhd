
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Latch_SR_alto is
    Port ( S : in  STD_LOGIC;
           R : in  STD_LOGIC;
           NQ : out  STD_LOGIC;
           Q : out  STD_LOGIC);
end Latch_SR_alto;

architecture Behavioral of Latch_SR_alto is

signal Q_aux : std_logic;
signal NQ_aux : std_logic;

begin

NQ_aux <= S nand Q_aux;
Q_aux <= R nand NQ_aux;

NQ <= NQ_aux;
Q <= Q_aux;

end Behavioral;


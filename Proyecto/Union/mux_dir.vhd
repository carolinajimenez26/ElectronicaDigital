library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_dir is
    Port ( sel : in  STD_LOGIC;
           dir : in  STD_LOGIC_VECTOR (22 downto 0);
           dir2 : in  STD_LOGIC_VECTOR (22 downto 0);
           dir_out : out  STD_LOGIC_VECTOR (22 downto 0)
			  );
end mux_dir;

architecture Behavioral of mux_dir is

begin


dir_out <=dir WHEN sel ='1' ELSE 
            dir2; 

end Behavioral;


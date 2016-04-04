
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Latch_D_TB IS
END Latch_D_TB;
 
ARCHITECTURE behavior OF Latch_D_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Latch
    PORT(
         D : IN  std_logic;
         E : IN  std_logic;
         Q : OUT  std_logic;
         QN : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic := '0';
   signal E : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   signal QN : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Latch PORT MAP (
          D => D,
          E => E,
          Q => Q,
          QN => QN
        );


   -- Stimulus process
   stim_proc: process
   begin		
      D <='0';
		E <='1';
      wait for 20 ns;
		
		D <='1';
      wait for 20 ns;
		
		E <='0';
      wait for 20 ns;

      wait;
   end process;

END;

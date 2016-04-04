
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Latch_SRE_bajo_TB IS
END Latch_SRE_bajo_TB;
 
ARCHITECTURE behavior OF Latch_SRE_bajo_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Latch_SRE_bajo
    PORT(
         S : IN  std_logic;
         E : IN  std_logic;
         R : IN  std_logic;
         Q : OUT  std_logic;
         NQ : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal S : std_logic := '0';
   signal E : std_logic := '0';
   signal R : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   signal NQ : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Latch_SRE_bajo PORT MAP (
          S => S,
          E => E,
          R => R,
          Q => Q,
          NQ => NQ
        );


   -- Stimulus process
   stim_proc: process
   begin		
      E<='0';
      S<='0';
		R<='0';
		wait for 20ns;
      
		R<='1';
		wait for 20ns;
		
		S<='1';
		wait for 20ns;
		
		R<='0';
		wait for 20ns;
		
		E<='1';
		wait for 20ns;
		
		R<='1';
      wait;
   end process;

END;

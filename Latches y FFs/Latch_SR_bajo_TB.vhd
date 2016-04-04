
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Latch_SR_bajo_TB IS
END Latch_SR_bajo_TB;
 
ARCHITECTURE behavior OF Latch_SR_bajo_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Latch_SR_bajo
    PORT(
         S : IN  std_logic;
         R : IN  std_logic;
         Q : OUT  std_logic;
         NQ : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal S : std_logic := '0';
   signal R : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   signal NQ : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Latch_SR_bajo PORT MAP (
          S => S,
          R => R,
          Q => Q,
          NQ => NQ
        );

   
	stim_proc: process
	begin		
      
		S<='0';
		R<='0';
		wait for 20ns;
      
		R<='1';
		wait for 20ns;
		
		S<='1';
		wait for 20ns;
		
		R<='0';
		wait for 20ns;

      wait;
   end process;

END;

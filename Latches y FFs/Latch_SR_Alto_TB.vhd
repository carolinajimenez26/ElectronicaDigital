LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Latch_SR_Alto_TB IS
END Latch_SR_Alto_TB;
 
ARCHITECTURE behavior OF Latch_SR_Alto_TB IS 
 

 
    COMPONENT Latch_SR_alto
    PORT(
         S : IN  std_logic;
         R : IN  std_logic;
         NQ : OUT  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal S : std_logic := '1';
   signal R : std_logic := '1';

 	--Outputs
   signal NQ : std_logic;
   signal Q : std_logic;

 
 
BEGIN

   uut: Latch_SR_alto PORT MAP (
          S => S,
          R => R,
          NQ => NQ,
          Q => Q
        );

   stim_proc: process
  begin		
		S<='1';
		R<='1';
		wait for 20ns;
      
		R<='0';
		wait for 20ns;
		
		S<='0';
		wait for 20ns;
		
		R<='1';
		wait for 20ns;
		
		R<='0';
		wait for 20ns;

      wait;
   end process;

END;

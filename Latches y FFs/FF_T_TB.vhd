
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY FF_T_TB IS
END FF_T_TB;
 
ARCHITECTURE behavior OF FF_T_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FF_T
    PORT(
         T : IN  std_logic;
         CLK : IN  std_logic;
         Q : OUT  std_logic;
         NQ : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal T : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal Q : std_logic:='0';
   signal NQ : std_logic:='0';

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FF_T PORT MAP (
          T => T,
          CLK => CLK,
          Q => Q,
          NQ => NQ
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      T <= '0';
		wait for 20 ns;
		
      T <= '1';
		wait for 20 ns;
 		
      wait;
   end process;

END;

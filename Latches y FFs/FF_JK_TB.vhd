
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY FF_JK_TB IS
END FF_JK_TB;
 
ARCHITECTURE behavior OF FF_JK_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FF_JK
    PORT(
         clk : IN  std_logic;
         J : IN  std_logic;
         K : IN  std_logic;
         Q : OUT  std_logic;
         NQ : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal J : std_logic := '0';
   signal K : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   signal NQ : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FF_JK PORT MAP (
          clk => clk,
          J => J,
          K => K,
          Q => Q,
          NQ => NQ
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      J <= '0';
		K <= '1';
		wait for 20 ns;
		
		K <= '0';
		wait for 20 ns;
		
		J <= '1';
		wait for 20 ns;
		
		K <= '1';
		wait for 20 ns;
		
      wait;
   end process;

END;

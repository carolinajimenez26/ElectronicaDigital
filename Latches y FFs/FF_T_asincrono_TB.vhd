
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY FF_T_asincrono_TB IS
END FF_T_asincrono_TB;
 
ARCHITECTURE behavior OF FF_T_asincrono_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FF_T_asincrono
    PORT(
         T : IN  std_logic;
         Clk : IN  std_logic;
         PRE : IN  std_logic;
         CLR : IN  std_logic;
         Q : OUT  std_logic;
         NQ : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal T : std_logic := '0';
   signal Clk : std_logic := '0';
   signal PRE : std_logic := '0';
   signal CLR : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   signal NQ : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FF_T_asincrono PORT MAP (
          T => T,
          Clk => Clk,
          PRE => PRE,
          CLR => CLR,
          Q => Q,
          NQ => NQ
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		PRE <='1';
		CLR <='1';
		T <= '0';
		wait for 20 ns;
		
      T <= '1';
		wait for 20 ns;
		
		PRE <= '0';
		wait for 20 ns;
		
		PRE <= '1';
		CLR <= '0';
		wait for 20 ns;
		
      wait;
   end process;

END;

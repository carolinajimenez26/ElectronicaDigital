
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Receiver_tb IS
END Receiver_tb;
 
ARCHITECTURE behavior OF Receiver_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Receiver
    PORT(
			clk : IN  std_logic;
         Line : IN  std_logic;
         div : IN  std_logic;
         Data : OUT  std_logic_vector(7 downto 0);
         receive : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Line : std_logic := '0';
   signal div : std_logic := '0';
	signal clk : std_logic := '0';

 	--Outputs
   signal Data : std_logic_vector(7 downto 0);
   signal receive : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
	constant Baudios : time := 52083 ns;
	constant clk_period : time := 20 ns;
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Receiver PORT MAP (
			 clk => clk,
          Line => Line,
          div => div,
          Data => Data,
          receive => receive
        );

   -- Clock process definitions
	
	reloj: process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		div <= '0';
		wait for Baudios;
	
		div <= '1';
      Line <= '0';--bit de inicio
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit inicial guardada vector(7)
		wait for clk_period;
	
		div <= '0';
		wait for Baudios;
	
		div <= '1';
		Line <= '0';--bit 2
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit 3
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit 4
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '0';--bit 5
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '0';--bit 6
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit 7
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '0';--bit 8
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit de parada
		wait for clk_period;
		
		--Dato 2
		
		div <= '0';
		wait for Baudios;
	
		div <= '1';
      Line <= '0';--bit de inicio
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit inicial guardada vector(7)
		wait for clk_period;
	
		div <= '0';
		wait for Baudios;
	
		div <= '1';
		Line <= '1';--bit 2
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit 3
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit 4
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit 5
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit 6
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit 7
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit 8
		wait for clk_period;
		
		div <= '0';
		wait for Baudios;
		
		div <= '1';
		Line <= '1';--bit de parada
		wait for clk_period;
		
		
      wait;
   end process;

END;

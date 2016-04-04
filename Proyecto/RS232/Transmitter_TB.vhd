
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY Transmitter_TB IS
END Transmitter_TB;
 
ARCHITECTURE behavior OF Transmitter_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Transmitter
    PORT(
         div : IN  std_logic;
         clk : IN  std_logic;
         data : IN  std_logic_vector(7 downto 0);
         send : IN  std_logic;
         Line : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal div : std_logic := '0';
   signal clk : std_logic := '0';
   signal data : std_logic_vector(7 downto 0) := (others => '0');
   signal send : std_logic := '0';

 	--Outputs
   signal Line : std_logic;

   -- Clock period definitions
	constant Baudios : time := 52083 ns;
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Transmitter PORT MAP (
          div => div,
          clk => clk,
          data => data,
          send => send,
          Line => Line
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
		div <= '0';
		wait for Baudios;
	
		div <= '1';
      send <= '1';
      data <= "00101001";
      wait for Baudios;
		send <= '0';
		
		


      wait;
   end process;

END;

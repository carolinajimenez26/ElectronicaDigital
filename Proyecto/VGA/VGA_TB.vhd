
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY VGA_TB IS
END VGA_TB;
 
ARCHITECTURE behavior OF VGA_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT VGA
    PORT(
         CLK : IN  std_logic;
         SHS : OUT  std_logic;
         SVS : OUT  std_logic;
         RGB_Entrada : IN  std_logic_vector(2 downto 0);
         RGB : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RGB_Entrada : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal SHS : std_logic;
   signal SVS : std_logic;
   signal RGB : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: VGA PORT MAP (
          CLK => CLK,
          SHS => SHS,
          SVS => SVS,
          RGB_Entrada => RGB_Entrada,
          RGB => RGB
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		RGB_Entrada <= "101";
		
      wait for clk_period*10;

      -- insert stimulus here 
      wait;
   end process;

END;

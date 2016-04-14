
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY Modulo2_TB IS
END Modulo2_TB;
 
ARCHITECTURE behavior OF Modulo2_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Modulo
    PORT(
         CLK : IN  std_logic;
         WEA : IN  std_logic;
         ENA : IN  std_logic;
         ADDRA : IN  std_logic_vector(2 downto 0);
         DIA : IN  std_logic_vector(4 downto 0);
         DOA : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal WEA : std_logic := '0';
   signal ENA : std_logic := '0';
   signal ADDRA : std_logic_vector(2 downto 0) := (others => '0');
   signal DIA : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal DOA : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Modulo PORT MAP (
          CLK => CLK,
          WEA => WEA,
          ENA => ENA,
          ADDRA => ADDRA,
          DIA => DIA,
          DOA => DOA
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
      ADDRA <= "001";
		DIA <= "11111";
		wait for 20 ns;
		
		ADDRA <= "010";
		DIA <= "11001";
		wait for 20 ns;
		
      wait;
   end process; 

END;

--Divisor de Frecuencia de UART TB

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Div_F_TB IS
END Div_F_TB;
 
ARCHITECTURE behavior OF Div_F_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Div_F
    PORT(
         CLK : IN  std_logic;
         D_UART : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';

 	--Outputs
   signal D_UART : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Div_F PORT MAP (
          CLK => CLK,
          D_UART => D_UART
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

END;

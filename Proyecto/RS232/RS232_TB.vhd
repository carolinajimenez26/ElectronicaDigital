
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY RS232_TB IS
END RS232_TB;
 
ARCHITECTURE behavior OF RS232_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RS232
    PORT(
         CLK : IN  std_logic;
         DATOS : IN  std_logic_vector(7 downto 0);
         ENVIAR : IN  std_logic;
         RX : IN  std_logic;
         DATOS_ENVIADOS : OUT  std_logic_vector(7 downto 0);
         RECIBIDO : OUT  std_logic;
         TX : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal DATOS : std_logic_vector(7 downto 0) := (others => '0');
   signal ENVIAR : std_logic := '0';
   signal RX : std_logic := '0';

 	--Outputs
   signal DATOS_ENVIADOS : std_logic_vector(7 downto 0);
   signal RECIBIDO : std_logic;
   signal TX : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
	constant baudios_period : time := 52080 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RS232 PORT MAP (
          CLK => CLK,
          DATOS => DATOS,
          ENVIAR => ENVIAR,
          RX => RX,
          DATOS_ENVIADOS => DATOS_ENVIADOS,
          RECIBIDO => RECIBIDO,
          TX => TX
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
	
		DATOS <= "00101001";
		
		ENVIAR <='1';
		
      RX <= '0';--bit de inicio
		wait for baudios_period;
	
		RX <= '1';--bit inicial guardada vector(7)
		wait for baudios_period;

		RX <= '0';--bit 2
		wait for baudios_period;

		RX <= '1';--bit 3
		wait for baudios_period;

		RX <= '1';--bit 4
		wait for baudios_period;

		RX <= '0';--bit 5
		wait for baudios_period;
		
		RX <= '0';--bit 6
		wait for baudios_period;

		RX <= '1';--bit 7
		wait for baudios_period;

		RX <= '0';--bit 8
		wait for baudios_period;

		RX <= '1';--bit de parada
		wait for baudios_period;
		
		--Dato 2
		
		RX <= '0';--bit de inicio
		wait for baudios_period;
	
		RX <= '1';--bit inicial guardada vector(7)
		wait for baudios_period;

		RX <= '1';--bit 2
		wait for baudios_period;

		RX <= '1';--bit 3
		wait for baudios_period;

		RX <= '1';--bit 4
		wait for baudios_period;

		RX <= '1';--bit 5
		wait for baudios_period;
		
		RX <= '1';--bit 6
		wait for baudios_period;

		RX <= '1';--bit 7
		wait for baudios_period;

		RX <= '1';--bit 8
		wait for baudios_period;

		RX <= '1';--bit de parada
		wait for baudios_period;
		
		ENVIAR <='0';
		
		
      wait;
   end process;

END;

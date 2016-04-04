library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MemoryController is
    Port (
			  -----------------------------------------------
			  --        Signals for the controller         --
			  -----------------------------------------------
			  clock				:	in		STD_LOGIC;								-- 100MHz
           address_in		:	in		STD_LOGIC_VECTOR (22 downto 0);	-- RAM address
			  go_in				:	in		STD_LOGIC;								-- if='1' starts the operation
			  write_in			:	in		STD_LOGIC;								-- if='0' => read; if='1' => write
			  data_in			:	in		STD_LOGIC_VECTOR (15 downto 0);	-- data that has to be written
			  data_out			:	out	STD_LOGIC_VECTOR (15 downto 0);	-- data that has been read
			  -----------------------------------------------
			  -- Signals from the controller to the memory --
			  -----------------------------------------------
			  clock_out			:	out 	STD_LOGIC;
			  ADDRESS			:	out	STD_LOGIC_VECTOR (22 downto 0);
			  ADV					:	out	STD_LOGIC;
			  CRE					:	out	STD_LOGIC;
			  CE					:	out	STD_LOGIC;
			  OE					:	out	STD_LOGIC;
			  WE					:	out	STD_LOGIC;
			  LB					:	out	STD_LOGIC;
			  UB					:	out	STD_LOGIC;
			  DATA				:	inout	STD_LOGIC_VECTOR (15 downto 0)
			 );
end MemoryController;

architecture Behavioral of MemoryController is

	type state is (init, idle, writing, reading);
	signal next_state, current_state : state := init;
--	signal next_state, current_state : state := idle; -- for TESTING

	-- Clock source = 100MHz - 10ns
	constant init_counter : integer := (75500); -- 151 microseconds
	constant timing_counter : integer := (3-1); -- 70 nanoseconds

	signal counter, next_counter : integer range 0 to init_counter := 0;

	signal writing_out : STD_LOGIC := '0';

	signal current_data_out, next_data_out : std_logic_vector(15 downto 0):= (others => '0');

begin

	ADDRESS <= address_in;
	clock_out <= '0'; -- always '0' since this controller operates in asynchronous mode
	CRE <= '0'; -- always '0' because this controller uses the default configuration

	DATA <= data_in when writing_out='1' else (others => 'Z');
	data_out <= current_data_out;

	-- FSM process
	process(clock)
	begin
		if (rising_edge(clock)) then
			current_state <= next_state;
			counter <= next_counter;
			current_data_out <= next_data_out;
		end if;
	end process;

	-- FSM states
	process(current_state, counter, go_in, write_in, DATA, current_data_out)
	begin
		next_counter <= counter;
		next_data_out <= current_data_out;

		-- Default outputs
		ADV <= '0'; -- always '0'
		CE <= '1';
		LB <= '1';
		UB <= '1';
		OE <= '1';
		WE <= '1';

		writing_out <= '0'; -- this signal drives the inout DATA port

		case current_state is
			-- Init
			when init =>
				ADV <= '1';
				next_data_out <= (others => '0');

				if (counter >= init_counter) then
					next_state <= idle;
					next_counter <= 0;
				else
					next_counter <= counter + 1;
					next_state <= init;
				end if;

			-- Idle
			when idle =>
				if (go_in = '0') then
					next_state <= idle;
				else -- if a signal of start is received
					if (write_in = '0') then -- start the reading
						next_state <= reading;
					else -- start the writing
						next_state <= writing;
					end if;
				end if;

			-- Writing
			when writing =>
				writing_out <= '1';

				if (counter >= timing_counter) then -- the data has been written
					next_counter <= 0;
					next_state <= idle;
				else
					CE <= '0';
					LB <= '0';
					UB <= '0';
					OE <= '0';
					WE <= '0';

					next_counter <= counter + 1;
					next_state <= writing;
				end if;

			-- Reading
			when reading =>
				if (counter >= timing_counter) then -- the data has been read
					next_counter <= 0;
					next_data_out <= DATA;
					next_state <= idle;
				else
					CE <= '0';
					LB <= '0';
					UB <= '0';
					OE <= '0';

					next_counter <= counter + 1;
					next_state <= reading;
				end if;
		end case;
	end process;

end Behavioral;



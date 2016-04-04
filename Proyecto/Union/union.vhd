library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity union is
    Port ( 
	     clk : in  STD_LOGIC;
		  sel : in std_logic;
		  pdb        : inout std_logic_vector(7 downto 0);
        astb     : in std_logic;
        dstb     : in std_logic;
        pwr     : in std_logic;
        rgSwt    : in std_logic_vector(7 downto 0);
		  pwait     : out std_logic;
     ---   rgBtn    : in std_logic_vector(4 downto 0);
		  clock_out			:	out 	STD_LOGIC;
			  ADDRESS			:	out	STD_LOGIC_VECTOR (22 downto 0);
			  ADV					:	out	STD_LOGIC;
			  CRE					:	out	STD_LOGIC;
			  CE					:	out	STD_LOGIC;
			  OE					:	out	STD_LOGIC;
			  WE					:	out	STD_LOGIC;
			  LB					:	out	STD_LOGIC;
			  UB					:	out	STD_LOGIC;
			  DATA				:	inout	STD_LOGIC_VECTOR (15 downto 0);
			  SHS : out  STD_LOGIC;
           SVS : out  STD_LOGIC;
			  RGB : out  STD_LOGIC_VECTOR (2 downto 0)
	 
	 );
end union;

architecture Behavioral of union is

component dpimref
    Port (
        mclk     : in std_logic;
        pdb        : inout std_logic_vector(7 downto 0);
        astb     : in std_logic;
        dstb     : in std_logic;
        pwr     : in std_logic;
        pwait     : out std_logic;
        rgLed    : out std_logic_vector(7 downto 0);
        rgSwt    : in std_logic_vector(7 downto 0);
        rgBtn    : in std_logic_vector(4 downto 0)
    );
end component;

component MemoryController
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
end component;

component mux_dir
    Port ( sel : in  STD_LOGIC;
           dir : in  STD_LOGIC_VECTOR (22 downto 0);
           dir2 : in  STD_LOGIC_VECTOR (22 downto 0);
           dir_out : out  STD_LOGIC_VECTOR (22 downto 0));
end component;


component VGA
    Port ( CLK : in  STD_LOGIC;
           SHS : out  STD_LOGIC;
           SVS : out  STD_LOGIC;
           RGB_Entrada : in  STD_LOGIC_VECTOR (2 downto 0);
			  control_dir : out std_logic;
           RGB : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component vga_hab
    Port ( TD_vga : in  STD_LOGIC;
           selec : in  STD_LOGIC;
           hab : out  STD_LOGIC);
end component;

component conda
    Port ( pwai : in  STD_LOGIC;
           direcc : out  STD_LOGIC_VECTOR (22 downto 0));
end component;

COMPONENT RS232
	PORT(
		CLK : IN std_logic;
		DATOS : IN std_logic_vector(7 downto 0);
		ENVIAR : IN std_logic;
		RX : IN std_logic;          
		DATOS_ENVIADOS : OUT std_logic_vector(7 downto 0);
		RECIBIDO : OUT std_logic;
		TX : OUT std_logic;
		TRANSMITIDO : OUT std_logic
		);
	END COMPONENT;


signal aux_pwait : std_logic;
signal aux_rgled: std_logic_vector(7 downto 0);
signal aux_dir1, aux_dir2 , dir_RAM : std_logic_vector(22 downto 0);
signal TD_aux : std_logic;
signal gos : std_logic;
signal data_aux, data_auxOUT : std_logic_vector(15 downto 0);
signal aux_hab :std_logic;
signal ready_aux1 :std_logic;
signal ready_aux2 :std_logic;

begin

pwait <= aux_pwait;
gos <= '1';
data_aux(15 downto 8) <= "00000000";
data_aux(7 downto 0) <= aux_rgled;

inst_cond_vga : conda port map(
	aux_hab, aux_dir2,
	ready => ready_aux1
);

inst_cont_pwait: conda port map(
	aux_pwait, aux_dir1,
	ready => ready_aux2
);

inst_vga_hab : vga_hab port map(
	TD_vga => TD_aux,
	selec => sel,
	hab => aux_hab
);


inst_VGA : VGA port map(
			  CLK => clk,
           SHS => SHS,
           SVS => SVS,
           RGB_Entrada => data_auxOUT(2 downto 0),
			  control_dir => TD_aux,
           RGB => RGB
);

inst_dpimref : dpimref port map(
	mclk => clk,
	pdb => pdb,
	astb => astb,
	dstb => dstb,
	pwr => pwr,
	pwait => aux_pwait,
	rgLed => aux_rgled,
	rgSwt => rgSwt,
	rgBtn => "00000"
);


inst_muxdir : mux_dir port map(
	sel => sel,
	dir => aux_dir1,
	dir2 => aux_dir2,
	dir_out => dir_RAM
	
);


inst_mem : MemoryController port map(
	        clock => clk,						
           address_in => dir_RAM,
			  go_in => gos,								
			  write_in => sel,
			  data_in => data_aux,
			  data_out => data_auxOUT,	
			  -----------------------------------------------
			  clock_out => clock_out,
			  ADDRESS => ADDRESS,
			  ADV	=> ADV,
			  CRE	=> CRE,
			  CE =>	CE,
			  OE	=> OE,
			  WE	=> WE,
			  LB => LB,
			  UB => UB,
			  DATA => DATA
);


	Inst_RS232: RS232 PORT MAP(
		CLK => clk,
		DATOS => ,
		ENVIAR => ready_aux2 and ready_aux1,
		RX => ,
		DATOS_ENVIADOS => ,
		RECIBIDO => ,
		TX => ,
		TRANSMITIDO => 
	);


end Behavioral;


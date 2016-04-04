
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VGA is
    Port ( CLK : in  STD_LOGIC;
           SHS : out  STD_LOGIC;
           SVS : out  STD_LOGIC;
           RGB_Entrada : in  STD_LOGIC_VECTOR (2 downto 0);
           RGB : out  STD_LOGIC_VECTOR (2 downto 0));
end VGA;

architecture Behavioral of VGA is

signal div_aux:STD_LOGIC;
signal S_vs: std_logic; --para conectar hs con vs
signal Stdisp_vs: std_logic;signal Stdisp_hs: std_logic;
signal St_disp_hs_vs: std_logic; --salida de la and 

COMPONENT Div_F_UART
	PORT(
		CLK : IN std_logic;          
		Div_UART : OUT std_logic
		);
	END COMPONENT;

	COMPONENT HS
	PORT(
		clk : IN std_logic;
		div : IN std_logic;
		vs : IN std_logic;          
		disp_hs : OUT std_logic;
		hs : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT VS
	PORT(
		clk : IN std_logic;
		div : IN std_logic;          
		disp_vs : OUT std_logic;
		salida : OUT std_logic;
		vs : OUT std_logic
		);
	END COMPONENT;

	COMPONENT MUX
	PORT(
		a : IN std_logic_vector(2 downto 0);
		b : IN std_logic_vector(2 downto 0):= (others => '0');
		sel : IN std_logic;          
		salida : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

begin

	Inst_Div_F_UART: Div_F_UART PORT MAP(
			CLK => clk,
		Div_UART => div_aux
	);
	
	Inst_VS: VS PORT MAP(
		CLK => clk,
		div => div_aux,
		disp_vs => Stdisp_vs ,
		salida => S_vs,
		vs => SVS
	);
	
	Inst_HS: HS PORT MAP(
		CLK => clk,
		div => div_aux,
		vs => S_vs,
		disp_hs => Stdisp_hs,
		hs => SHS
	);
	
	St_disp_hs_vs <= Stdisp_vs and Stdisp_hs;
	
	Inst_MUX: MUX PORT MAP(
		a => "000", --constante		b => RGB_ENTRADA,
		sel => St_disp_hs_vs,
		salida => RGB
	);

end Behavioral;


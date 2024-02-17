library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
	port(
		clk : in std_logic;
		rst : in std_logic;
		n : in std_logic_vector(5 downto 0);
		result : out std_logic_vector(23 downto 0);
		n_en : in std_logic;
		result_en : in std_logic;
		result_sel : in std_logic;
		x_en : in std_logic;
		x_sel : in std_logic;
		y_en : in std_logic;
		y_sel : in std_logic;
		i_en : in std_logic;
		i_sel : in std_logic;
		n_eq_0 : out std_logic;
		i_le_n : out std_logic
	);
end datapath;

-- ARCHITECTURE:
architecture structure of datapath is

	-- SIGNAL DECLARATION
	signal nregout, iregout, imuxout, add1out: std_logic_vector(5 downto 0);
	signal xmuxout, xregout, ymuxout, yregout, add2out, rmuxout : std_logic_vector(23 downto 0);
	
begin

	-- COMPONENTS:
	
	-- MUXES
	MUX_I: entity work.mux_21(bhv)
		generic map(width => 6)
		port map(
			in1 => add1out,
			in2 => "000010",
			sel => i_sel,
			output => imuxout
		);
		
	MUX_X: entity work.mux_21(bhv)
		generic map(width => 24)
		port map(
			in1 => yregout,
			in2 => (others => '0'),
			sel => x_sel,
			output => xmuxout
		);
	
	MUX_Y: entity work.mux_21(bhv)
		generic map(width => 24)
		port map(
			in1 => add2out,
			in2 => "000000000000000000000001",
			sel => y_sel,
			output => ymuxout
		);
		
	MUX_R: entity work.mux_21(bhv)
		generic map(width => 24)
		port map(
			in1 =>  yregout,
			in2 => (others => '0'),
			sel => result_sel,
			output => rmuxout
		);
		
	-- REGS
	REG_I: entity work.reg(bhv)
		generic map(width => 6)
		port map(
			clk => clk,
			rst => rst,
			en => i_en,
			in1 => imuxout,
			output => iregout
		);
		
	REG_X: entity work.reg(bhv)
		generic map(width => 24)
		port map(
			clk => clk,
			rst => rst,
			en => x_en,
			in1 => xmuxout,
			output => xregout
		);
	
	REG_Y: entity work.reg(bhv)
		generic map(width => 24)
		port map(
			clk => clk,
			rst => rst,
			en => y_en,
			in1 => ymuxout,
			output => yregout
		);
	
	REG_R: entity work.reg(bhv)
		generic map(width => 24)
		port map(
			clk => clk,
			rst => rst,
			en => result_en,
			in1 => rmuxout,
			output => result
		);
	
	REG_N: entity work.reg(bhv)
		generic map(width => 6)
		port map(
			clk => clk,
			rst => rst,
			en => n_en,
			in1 => n,
			output => nregout
		);
	
	-- COMPARATORS
	LTE: entity work.lte_comp(bhv)
		port map(
			in1 => iregout,
			in2 => nregout,
			output => i_le_n
		);
	
	ZERO: entity work.zero_comp(bhv)
		port map(
			in1 => nregout,
			output => n_eq_0
		);
	
	--ADDERS
	ADDXY: entity work.adder(bhv)
		generic map(width => 24)
		port map(
			in1 => xregout,
			in2 => yregout,
			output => add2out
		);
	
	ADDI: entity work.adder(bhv)
		generic map(width => 6)
		port map(
			in1 => iregout,
			in2 => "000001",
			output => add1out
		);
end structure;
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port (
        clk      : in  std_logic;
        switch   : in  std_logic_vector(9 downto 0);
		  button   : in  std_logic_vector(1 downto 0);
        led0     : out std_logic_vector(6 downto 0);
        led0_dp  : out std_logic;
        led1     : out std_logic_vector(6 downto 0);
        led1_dp  : out std_logic;
        led2     : out std_logic_vector(6 downto 0);
        led2_dp  : out std_logic;
        led3     : out std_logic_vector(6 downto 0);
        led3_dp  : out std_logic;
        led4     : out std_logic_vector(6 downto 0);
        led4_dp  : out std_logic;
        led5     : out std_logic_vector(6 downto 0);
        led5_dp  : out std_logic
    );
end top_level;

architecture default of top_level is

    signal n_en       : std_logic;
    signal result_en  : std_logic;
    signal result_sel : std_logic;
    signal x_en       : std_logic;
    signal x_sel      : std_logic;
    signal y_en       : std_logic;
    signal y_sel      : std_logic;
    signal i_en       : std_logic;
    signal i_sel      : std_logic;
    signal n_eq_0     : std_logic;
    signal i_le_n     : std_logic;
	
	
	signal go		: std_logic;
	signal rst     : std_logic;

	signal result   : std_logic_vector(23 downto 0);
   signal done     : std_logic;

begin
    
	rst <= not button(0);
	go  <= not button(1);

	DATAPATH : entity work.datapath 
		port map (
			clk => clk,
			rst => rst,
			n => switch(5 downto 0),
			result => result,
			n_en => n_en,
			result_en => result_en,
			result_sel =>  result_sel,
			x_en => x_en,
			x_sel => x_sel,
			y_en => y_en,
			y_sel =>  y_sel,
			i_en => i_en,
			i_sel =>  i_sel,
			n_eq_0 => n_eq_0,
			i_le_n => i_le_n
	);
	
	FSM : entity work.fsm 
		port map (
			clk  => clk,
			rst  => rst,
			go   => go,
			done => done,
			n_en => n_en,
			result_en => result_en,
			result_sel => result_sel,
			x_en => x_en,
			x_sel => x_sel,
			y_en => y_en,
			y_sel => y_sel,
			i_en => i_en,
			i_sel => i_sel,
			n_eq_0 => n_eq_0,
			i_le_n  => i_le_n
	);   

	U_LED0 : entity work.decode7seg 
		port map (
			input  => result(3 downto 0),
			output => led0
	);

    U_LED1 : entity work.decode7seg 
		port map (
			input  => result(7 downto 4),
			output => led1
	);
    
    U_LED2 : entity work.decode7seg 
		port map (
        	input  => result(11 downto 8),
        	output => led2
	);

    U_LED3 : entity work.decode7seg 
		port map (
        	input  => result(15 downto 12),
        	output => led3
	);
    
    U_LED4 : entity work.decode7seg
		port map (
        	input  => result(19 downto 16),
        	output => led4
	);

    U_LED5 : entity work.decode7seg 
		port map (
        	input  => result(23 downto 20),
        	output => led5
	);
    

    led5_dp <= NOT done;
    led4_dp <= NOT done;
    led3_dp <= NOT done;
    led2_dp <= NOT done;
    led1_dp <= NOT done;
    led0_dp <= NOT done;
end architecture;

--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

--entity top_level is
--    port (
--        clk      : in  std_logic;
--        switch   : in  std_logic_vector(9 downto 0);
--		  button   : in  std_logic_vector(1 downto 0);
--        led0     : out std_logic_vector(6 downto 0);
--        led0_dp  : out std_logic;
--        led1     : out std_logic_vector(6 downto 0);
--        led1_dp  : out std_logic;
--        led2     : out std_logic_vector(6 downto 0);
--        led2_dp  : out std_logic;
--        led3     : out std_logic_vector(6 downto 0);
--        led3_dp  : out std_logic;
--        led4     : out std_logic_vector(6 downto 0);
--        led4_dp  : out std_logic;
--        led5     : out std_logic_vector(6 downto 0);
--        led5_dp  : out std_logic
--    );
--end top_level;
--
--architecture default of top_level is
--
--    signal n_en       : std_logic;
--    signal result_en  : std_logic;
--    signal result_sel : std_logic;
--    signal x_en       : std_logic;
--    signal x_sel      : std_logic;
--    signal y_en       : std_logic;
--    signal y_sel      : std_logic;
--    signal i_en       : std_logic;
--    signal i_sel      : std_logic;
--    signal n_eq_0     : std_logic;
--    signal i_le_n     : std_logic;
--	
--	
--	signal go		: std_logic;
--	signal rst     : std_logic;
--
--	signal result   : std_logic_vector(23 downto 0);
--   signal done     : std_logic;
--
--begin
--    
--	rst <= not button(0);
--	go  <= not button(1);
--
--	DATAPATH : entity work.datapath 
--		port map (
--			clk => clk,
--			rst => rst,
--			n => switch(5 downto 0),
--			result => result,
--			n_en => n_en,
--			result_en => result_en,
--			result_sel =>  result_sel,
--			x_en => x_en,
--			x_sel => x_sel,
--			y_en => y_en,
--			y_sel =>  y_sel,
--			i_en => i_en,
--			i_sel =>  i_sel,
--			n_eq_0 => n_eq_0,
--			i_le_n => i_le_n
--	);
--	
--	FSM: entity work.fsm
--	port map(
--		clk => clk,
--		rst => rst,
--		go => go,
--		done => done,
--		n_en => n_en,
--		result_en => result_en,
--		result_sel => result_sel,
--		x_en => x_en,
--		x_sel => x_sel,
--		y_en => y_en,
--		y_sel => y_sel,
--		i_en => i_en,
--		i_sel => i_sel,
--		n_eq_0 => n_eq_0,
--		i_le_n => i_le_n
--	);
--	
--	--FSM : entity work.fsm 
--	--	port map (
--	--		ID_S_b88665f_7e7082e6_E  => clk,
--	--		ID_S_b88a71e_7e341cf6_E  => rst,
--	--		ID_S_5977fb_7ffcc7f4_E   => go,
--	--		ID_S_7c95cc2b_1b9f1d82_E => done,
--	--		ID_S_7c9b02c5_598fa886_E => n_en,
--	--		ID_S_34b84a16_43f520dd_E => result_en,
--	--		ID_S_4bc1c7a7_6b4b6d0f_E => result_sel,
--	--		ID_S_7ca07e8f_1cbd60fa_E => x_en,
--	--		ID_S_10b08b40_41c21917_E => x_sel,
--	--		ID_S_7ca10af0_3cf54137_E => y_en,
--	--		ID_S_10c2a3c1_4193da63_E => y_sel,
--	--		ID_S_7c9844e0_38774de5_E => i_en,
--	--		ID_S_fa11bb1_487fe2b_E   => i_sel,
--	--		ID_S_f66e137_35341610_E  => n_eq_0,
--	--		ID_S_3c0b9eb_239711a1_E  => i_le_n
--	--);   
--
--	U_LED0 : entity work.decode7seg 
--		port map (
--			input  => result(3 downto 0),
--			output => led0
--	);
--
--    U_LED1 : entity work.decode7seg 
--		port map (
--			input  => result(7 downto 4),
--			output => led1
--	);
--    
--    U_LED2 : entity work.decode7seg 
--		port map (
--        	input  => result(11 downto 8),
--        	output => led2
--	);
--
--    U_LED3 : entity work.decode7seg 
--		port map (
--        	input  => result(15 downto 12),
--        	output => led3
--	);
--    
--    U_LED4 : entity work.decode7seg
--		port map (
--        	input  => result(19 downto 16),
--        	output => led4
--	);
--
--    U_LED5 : entity work.decode7seg 
--		port map (
--        	input  => result(23 downto 20),
--        	output => led5
--	);
--    
--
--    led5_dp <= NOT done;
--    led4_dp <= NOT done;
--    led3_dp <= NOT done;
--    led2_dp <= NOT done;
--    led1_dp <= NOT done;
--    led0_dp <= NOT done;
--end architecture;
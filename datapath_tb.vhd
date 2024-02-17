library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath_tb is
end entity datapath_tb;

architecture tb_arch of datapath_tb is
    -- Constants
    constant CLK_PERIOD : time := 10 ns;
    
    -- Signals for testbench
    signal clk_tb       : std_logic := '0';
    signal rst_tb       : std_logic := '0';
    signal n_tb         : std_logic_vector(5 downto 0) := (others => '0');
    signal n_en_tb      : std_logic := '0';
    signal result_en_tb : std_logic := '0';
    signal result_sel_tb: std_logic := '0';
    signal x_en_tb      : std_logic := '0';
    signal x_sel_tb     : std_logic := '0';
    signal y_en_tb      : std_logic := '0';
    signal y_sel_tb     : std_logic := '0';
    signal i_en_tb      : std_logic := '0';
    signal i_sel_tb     : std_logic := '0';
    signal n_eq_0_tb    : std_logic;
    signal i_le_n_tb    : std_logic;
    signal result_tb    : std_logic_vector(23 downto 0);


begin

    -- Datapath instantiation
    DUT:entity work.datapath
    port map (
        clk         => clk_tb,
        rst         => rst_tb,
        n           => n_tb,
        result      => result_tb,
        n_en        => n_en_tb,
        result_en   => result_en_tb,
        result_sel  => result_sel_tb,
        x_en        => x_en_tb,
        x_sel       => x_sel_tb,
        y_en        => y_en_tb,
        y_sel       => y_sel_tb,
        i_en        => i_en_tb,
        i_sel       => i_sel_tb,
        n_eq_0      => n_eq_0_tb,
        i_le_n      => i_le_n_tb
    );

    -- Clock Process
    clk_process: process
    begin
        while now < 1000 ns loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process clk_process;

    -- Stimulus Process
    stimulus: process
    begin
        -- Reset
        rst_tb <= '1';
        wait for 5 * CLK_PERIOD;
        rst_tb <= '0';
        wait for 5 * CLK_PERIOD;

        -- Test 1: Basic Operation
        n_tb <= "001000";
		  result_sel_tb <= '1';
        x_sel_tb <= '1';
        y_sel_tb <= '1';
        i_sel_tb <= '1';
		  
		  wait for 10 * CLK_PERIOD;
		  
        n_en_tb <= '1';
        x_en_tb <= '1';
        y_en_tb <= '1';
        result_en_tb <= '1';
        wait for 10 * CLK_PERIOD;

        -- Test 2: Select different paths
        result_sel_tb <= '1';
        x_sel_tb <= '1';
        y_sel_tb <= '1';
        i_sel_tb <= '1';
        wait for 10 * CLK_PERIOD;


        wait;
    end process stimulus;

end architecture tb_arch;

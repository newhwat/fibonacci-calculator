library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.std_logic_1164.all;

entity fsm is 
	port(
		-- Primary input signals
		clk 		 : in std_logic;
		rst       : in std_logic;
		go        : in std_logic;
		-- Process complete signal
		done		 : out std_logic;
		-- Enables/Selectors:
		n_en      : out std_logic;
		result_en : out std_logic;
		result_sel: out std_logic;
		x_en      : out std_logic;
		x_sel     : out std_logic;
		y_en      : out std_logic;
		y_sel     : out std_logic;
		i_en      : out std_logic;
		i_sel     : out std_logic;
		-- Comparator inputs:
		n_eq_0    : in std_logic;
		i_le_n    : in std_logic
	);
end fsm;

architecture behavioral of fsm is
	type state_type is (wait_for_go, to_init, init, neq0, condition, looping, check_for_done, isdone, is_done_zero, restart, complete);
	signal state : state_type;
	
begin
	process(clk, rst)
	begin
		if (rst = '1') then
			state <= wait_for_go;
		elsif (rising_edge(clk)) then
			case state is
				when wait_for_go =>
					done <= '0';
					if (go = '1') then
						state <= init;
						done <= '0';
					end if;
				
				when to_init =>
					if (go = '1') then
						state <= to_init;
					else
						state <= init;
					end if;
				
				when init =>
					i_sel  <= '1';
					x_sel  <= '1';
					y_sel  <= '1';
					x_en   <= '0';
					y_en   <= '0';
					i_en   <= '0';
					n_en   <= '0';
					state <= neq0;
				
				when neq0 =>
					n_en <= '1';
					x_en <= '1';
					y_en <= '1';
					i_en <= '1';
					if (n_eq_0 = '1') then
						state <= is_done_zero;
					else
						state <= condition;
					end if;
				
				when condition => 
					n_en <= '1';
					x_en <= '1';
					y_en <= '1';
					i_en <= '1';
					state <= looping;
					
				when check_for_done =>
					if (i_le_n = '1') then
						state <= condition;
					else	
						state <= isdone;
						result_en <= '1';
					end if;

					
				when looping =>
					i_sel <= '0';
					x_sel <= '0';
					y_sel <= '0';
					i_en <= '0';
					x_en <= '0';
					y_en <= '0';
					n_en <= '0';
					state <= check_for_done;
				
				when is_done_zero =>
					x_en <= '0';
					y_en <= '0';
					i_en <= '0';
					result_sel <= '1';
					result_en <= '1';
					state <= restart;
				
				when isdone =>
					x_en <= '0';
					y_en <= '0';
					i_en <= '0';
					result_sel <= '0';
					result_en <= '1';
					state <= restart;
					
				when complete => 
					done <= '1';
					state <= restart;
				
				when restart =>
					x_en <= '0';
					y_en <= '0';
					i_en <= '0';
					result_en <= '1';
					done <= '1';
					if (go = '0') then
						state <= restart;
					else
						state <= init;
					end if;
					
				when others => null;
			end case;
		end if;
	end process;
end behavioral;
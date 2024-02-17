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

-- ARCHITECTURE
architecture behavioral of fsm is
	type state_type is (wait_for_go, init, conditional, addition, result_zero, result, complete, neq0, restart);
	signal current_state, next_state: state_type; 
	
begin 
	process(clk, rst)
	begin
		if (rst = '1') then
			current_state <= wait_for_go;
		elsif (rising_edge(clk)) then
			current_state <= next_state;
		end if;
	end process;
	
	process(go, n_eq_0, i_le_n, current_state)
	begin
		done <= '0';
		n_en <= '0';
		result_en <= '0'; 
		result_sel <= '0'; 
		x_en <= '0'; 
		x_sel <= '0'; 
		y_en <= '0'; 
		y_sel <= '0'; 
		i_en <= '0'; 
		i_sel <= '0'; 
		next_state <= current_state;
		
		case (current_state) is
			when wait_for_go => 
				done <= '0';
				result_sel <= '1';
				result_en <= '1';
				if (go = '0') then
					next_state <= wait_for_go;
				else 
					next_state <= init;
				end if;
			
			when init => 
				n_en <= '1'; 
				x_sel <= '1'; 
				x_en <= '1'; 
				y_sel <= '1'; 
				y_en <= '1'; 
				i_sel <= '1'; 
				i_en <= '1'; 
				done <= '0'; 
				next_state <= neq0;
				
			when neq0 =>
				if (n_eq_0 = '1') then
					next_state <= result_zero;
				else 
					next_state <= conditional;
				end if;
			
			when conditional =>
				if (i_le_n = '1') then
					next_state <= addition;
				else 
					next_state <= result;
				end if;
			
			when addition =>
				x_sel <= '0'; 
				x_en <= '1'; 
				y_sel <= '0'; 
				y_en <= '1'; 
				i_sel <= '0'; 
				i_en <= '1'; 
				next_state <= conditional; 
			
			when result_zero =>
				result_sel <= '1';
				result_en <= '1';
				next_state <= complete;
			
			when result => 
				result_sel <= '0';
				result_en <= '1';
				next_state <= complete;
			
			when complete =>
				done <= '1';
				if (go = '1') then
					next_state <= complete;
				else
					next_state <= restart;
				end if;
			
			when restart => 
				result_sel <= '0';
				x_en <= '0';
				y_en <= '0';
				i_en <= '0';
				result_en <= '0';
				done <= '1';
				if (go = '0') then
					next_state <= restart;
				else
					next_state <= init;
				end if;
			
			when others => null;
		end case;
	end process;
end behavioral;
		
		
		
		
		
		
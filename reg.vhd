library ieee;
use ieee.std_logic_1164.all;

entity reg is
	generic(
		width : positive := 24
	);
	port(
		-- INPUTS:
		clk : in std_logic;
		rst : in std_logic;
		en  : in std_logic;
		in1 : in std_logic_vector(width-1 downto 0);
		-- OUTPUT
		output : out std_logic_vector(width-1 downto 0)
	);
end reg;

-- ARCHITECTURE
architecture bhv of reg is
begin
	process(clk, rst, en, in1)
	begin
		-- ASYNC RESET:
		if (rst = '1') then
			output <= (others => '0');
		-- CLOCK PASSTHROUGH
		elsif (rising_edge(clk)) then
			-- CHECK IF ENABLED
			if (en = '1') then
				output <= in1;
			end if;
		end if;
	end process;
end bhv;

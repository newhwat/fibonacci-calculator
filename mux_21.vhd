library ieee;
use ieee.std_logic_1164.all;

entity mux_21 is
	generic(
		width : positive := 24
	);
	port(
		-- INPUTS
		in1 : in std_logic_vector(width-1 downto 0);
		in2 : in std_logic_vector(width-1 downto 0);
		sel : in std_logic;
		-- OUTPUT
		output : out std_logic_vector(width-1 downto 0)
	);
end mux_21;

-- ARCHITECTURE
architecture bhv of mux_21 is
begin
	process(in1, in2, sel)
	begin
		if (sel = '0') then
			output <= in1;
		elsif (sel = '1') then
			output <= in2;
		end if;
	end process;
end bhv;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	generic(
		width : positive := 24
	);
	port(
		-- INPUTS
		in1 : in std_logic_vector(width-1 downto 0);
		in2 : in std_logic_vector(width-1 downto 0);
		-- OUTPUT
		output : out std_logic_vector(width-1 downto 0)
	);
end adder;

-- ARCHITECTURE
architecture bhv of adder is
begin
	output <= std_logic_vector(unsigned(in1)+unsigned(in2));
end bhv;
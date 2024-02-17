library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lte_comp is
	port(
		-- INPUTS:
		in1 : in std_logic_vector(5 downto 0);
		in2 : in std_logic_vector(5 downto 0);
		-- OUTPUT:
		output : out std_logic
	);
end lte_comp;

-- ARCHITECTURE
architecture bhv of lte_comp is
begin
	process(in1, in2)
	begin
		if (unsigned(in1) <= unsigned(in2)) then
			output <= '1';
		else
			output <= '0';
		end if;
	end process;
end bhv;
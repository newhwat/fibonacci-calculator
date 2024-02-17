library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity zero_comp is
	port(
		-- INPUT
		in1 : in std_logic_vector(5 downto 0);
		
		-- OUTPUT
		output : out std_logic
	);
end zero_comp;

-- ARCHITECTURE 
architecture bhv of zero_comp is
begin
	process(in1)
	begin
		if (unsigned(in1) = "000000") then
			output <= '1';
		else
			output <= '0';
		end if;
	end process;
end bhv;
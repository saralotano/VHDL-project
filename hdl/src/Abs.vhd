library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Abs_module is
	generic(Nbit: integer);
	port (	 
	    input : in std_logic_vector (Nbit - 1 downto 0);
        output : out std_logic_vector (Nbit - 1 downto 0)
    );
end Abs_module;


architecture behavioral of Abs_module is

begin

	process(input)
		begin
			if (input(Nbit - 1) = '0') then 
				output <= input; --if the most significant bit is 0 the input value is positive and the output corresponds to the input
			else 				
				output <= std_logic_vector(unsigned(not(input)) + 1); --if the most significant bit is 1 the input value is negative and the output is computed as the complemented input + 1
			end if;
	end process;
		   
end behavioral;
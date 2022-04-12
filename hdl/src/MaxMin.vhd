library ieee;
use ieee.std_logic_1164.all;

entity MaxMin is
	generic(Nbit: positive);
	port (	 
	    input1 : in std_logic_vector (Nbit - 1 downto 0);
        input2 : in std_logic_vector (Nbit - 1 downto 0);
        max : out std_logic_vector (Nbit - 1 downto 0);
        min : out std_logic_vector (Nbit - 1 downto 0)
    );
end MaxMin;

architecture behavioral of MaxMin is

begin

	max <= input1 when (input1>input2) else input2;
	min <= input1 when (input1<=input2) else input2;
		   
end behavioral;
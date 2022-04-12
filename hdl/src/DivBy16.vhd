library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DivBy16 is
    generic (Nbit : positive);
    port (
        input : in std_logic_vector (Nbit - 1 downto 0);
        output : out std_logic_vector (Nbit - 1 downto 0)
    );
end DivBy16;

architecture behavioral of DivBy16 is 

begin

    output <= std_logic_vector(shift_right(unsigned(input) , 4)); --The division by 16 corresponds to the right shift of four positions (the most significant bits are filled with zeros) 
    
end behavioral;
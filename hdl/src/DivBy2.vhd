library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DivBy2 is
    generic (Nbit : positive);
    port (
        input : in std_logic_vector (Nbit - 1 downto 0);
        output : out std_logic_vector (Nbit - 1 downto 0)
    );
end DivBy2;

architecture behavioral of DivBy2 is
begin

    output <= std_logic_vector(shift_right(unsigned(input) , 1)); --The division by 2 corresponds to the right shift of one position (the most significant bit is filled with a zero) 

end behavioral;
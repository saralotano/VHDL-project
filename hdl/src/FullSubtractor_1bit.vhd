library ieee;
use ieee.std_logic_1164.all;

entity FullSubtractor_1bit is
    port(
        a   : in std_logic; --minuend
        b   : in std_logic; --subtrahend
        b_i : in std_logic; --borrow in
        o   : out std_logic;--difference
        b_o : out std_logic --borrow out
    );
end FullSubtractor_1bit;

architecture data_flow of FullSubtractor_1bit is

begin   

  o   <= a xor b xor b_i;
  b_o <= ((not a and b) or (b and b_i) or (not a and b_i));

end data_flow;
    
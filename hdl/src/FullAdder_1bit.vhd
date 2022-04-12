library ieee;
use ieee.std_logic_1164.all;


entity FullAdder_1bit is
    port(
        a   : in std_logic;	--first addend
        b   : in std_logic; --second addend
        c_i : in std_logic; --carry in
        o   : out std_logic;--sum 
        c_o : out std_logic --carry out
    );
end FullAdder_1bit;

architecture data_flow of FullAdder_1bit is

begin

  o   <= a xor b xor c_i;
  c_o <= (a and b) or (b and c_i) or (c_i and a);

end data_flow;
    
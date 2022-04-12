library ieee;
use ieee.std_logic_1164.all;

entity FullAdder_Nbit is 
   generic(Nbit : positive); 
   
    port(
        a   : in std_logic_vector(Nbit - 1 downto 0);
        b   : in  std_logic_vector(Nbit - 1 downto 0);
        c_i : in std_logic;
        o   : out  std_logic_vector(Nbit - 1 downto 0);
        c_o : out std_logic
        );
end FullAdder_Nbit;
   

architecture struct of FullAdder_Nbit is
   
    component FullAdder_1bit is               
	    port(
             a   : in std_logic;
             b   : in std_logic;
             c_i : in std_logic;
             o   : out std_logic;
             c_o : out std_logic
        );
	end component;

	signal c_int : std_logic_vector(Nbit downto 0); --c_int is and internal signal that connects the carry out of a previous FullAdder_1bit with the carry in of the next FullAdder_1bit.
    
	   
   begin          
	n_full_adder_gen : for i in 0 to Nbit - 1  generate 
    --generation of one FullAdder_1bit for each of the Nbit
	
	    i_full_adder : FullAdder_1bit 
            port map(
                a    =>  a(i),
     			b    =>  b(i), 
			    c_i  =>  c_int(i),
				o    =>  o(i),
				c_o  =>  c_int(i + 1)
            );
	       
	end generate;
			
		
	c_int(0) <= c_i;         -- Input carry mapping
	c_o <= c_int(Nbit);      -- Output carry mapping
		
end struct;
    
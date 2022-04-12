library ieee;
use ieee.std_logic_1164.all;


entity FullSubtractor_Nbit is
   generic(Nbit : positive);
   
    port(
        a   : in std_logic_vector(Nbit - 1 downto 0);
        b   : in  std_logic_vector(Nbit - 1 downto 0);
        b_i : in std_logic;
        o   : out  std_logic_vector(Nbit - 1 downto 0);
        b_o : out std_logic
        );
end FullSubtractor_Nbit;
   

architecture struct of FullSubtractor_Nbit is
   
    component FullSubtractor_1bit is               
	    port(
             a   : in std_logic;
             b   : in std_logic;
             b_i : in std_logic;
             o   : out std_logic;
             b_o : out std_logic
        );
	end component;

	signal b_int : std_logic_vector(Nbit downto 0); --b_int is and internal signal that connects the borrow out of a previous FullSubtractor_1bit with the borrow in of the next FullSubtractor_1bit.
    
	   
   begin          
	n_full_adder_gen : for i in 0 to Nbit - 1  generate
    --generation of one FullSubtractor_1bit for each of the Nbit
	
	    i_full_adder : FullSubtractor_1bit 
            port map(
                a    =>  a(i),
     			b    =>  b(i), 
			    b_i  =>  b_int(i),
				o    =>  o(i),
				b_o  =>  b_int(i + 1)
            );
	       
	end generate;
			
	b_int(0) <= b_i;    -- Input borrow mapping
	b_o <= b_int(Nbit); -- Output borrow mapping
		
end struct;
    
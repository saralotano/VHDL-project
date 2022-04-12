library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ComplexModulus is
	generic(Nbit: positive := 10);
	port (	 
	    input1 : in std_logic_vector (Nbit - 1 downto 0);
	    input2 : in std_logic_vector (Nbit - 1 downto 0);
        output : out std_logic_vector (Nbit - 1 downto 0)
    );

end ComplexModulus;

architecture behavioral of ComplexModulus is
	
	signal abs1 : std_logic_vector (9 downto 0);
	signal abs2 : std_logic_vector (9 downto 0);

	signal max : std_logic_vector (8 downto 0);
	signal min : std_logic_vector (8 downto 0);

	signal div2 : std_logic_vector (8 downto 0);
	signal sum1 : std_logic_vector (8 downto 0);
	signal c1: std_logic;

	signal sum2 : std_logic_vector (8 downto 0);
	signal c2: std_logic;

	signal div16 : std_logic_vector (9 downto 0);


	component Abs_module is
		generic (Nbit : positive);
		port (
			input : in std_logic_vector(Nbit - 1 downto 0);
			output : out std_logic_vector(Nbit - 1 downto 0)
		);
	end component;

	component MaxMin is
		generic (Nbit: positive);
		port (	 
		    input1 : in std_logic_vector (Nbit - 1 downto 0);
	        input2 : in std_logic_vector (Nbit - 1 downto 0);
	        max : out std_logic_vector (Nbit - 1 downto 0);
	        min : out std_logic_vector (Nbit - 1 downto 0)
	    );
	end component;

	component DivBy2 is
	    generic (Nbit : positive);
	    port (
	        input : in std_logic_vector (Nbit - 1 downto 0);
	        output : out std_logic_vector (Nbit - 1 downto 0)
	    );
	end component;

	component DivBy16 is
	    generic (Nbit : positive);
	    port (
	        input : in std_logic_vector (Nbit - 1 downto 0);
	        output : out std_logic_vector (Nbit - 1 downto 0)
	    );
	end component;

	component FullAdder_Nbit is
	    generic (Nbit : positive);
	    port(
	        a   : in std_logic_vector(Nbit - 1 downto 0);
	        b   : in std_logic_vector(Nbit - 1 downto 0);
	        c_i : in std_logic;
	        o   : out std_logic_vector(Nbit - 1 downto 0);
	        c_o : out std_logic
	        );
	end component;

	component FullSubtractor_Nbit is
	    generic (Nbit : positive);
	    port(
	        a   : in std_logic_vector(Nbit - 1 downto 0);
	        b   : in std_logic_vector(Nbit - 1 downto 0);
	        b_i : in std_logic;
	        o   : out std_logic_vector(Nbit - 1 downto 0);
	        b_o : out std_logic
	        );
	end component;


begin

	abs_1 : Abs_module
		generic map(
			Nbit => 10
		)
		port map(
			input => input1,
			output => abs1
		);

	abs_2 : Abs_module
		generic map(
			Nbit => 10
		)
		port map(
			input => input2,
			output => abs2
		);

	max_min: MaxMin
		generic map(
			Nbit => 9
		)
		port map(	 
		    input1 => abs1(8 downto 0), 
	        input2 => abs2(8 downto 0),
	        max => max,
	        min => min
	    );

	div_2: DivBy2
	    generic map(
	    	Nbit => 9
	    )
	    port map(
	        input => min,
	        output => div2
	    );

	adder_1 : FullAdder_Nbit
	   generic map(
	   		Nbit => 9
	   	)
	    port map(
	        a => div2,
	        b => max,
	        c_i => '0',
	        o => sum1,
	        c_o => c1
	    );

	adder_2 : FullAdder_Nbit
	   generic map(
	   		Nbit => 9
	   	)
	    port map(
	        a => min,
	        b => max,
	        c_i => '0',
	        o => sum2,
	        c_o => c2
	    );

	div_16: DivBy16
	    generic map(
	    	Nbit => 10
    	)
	    port map(
	        input(9) => c2,
	        input(8 downto 0) => sum2,
	        output => div16
	    );

	subtractor: FullSubtractor_Nbit
	    generic map(
	   		Nbit => 10
	   	)
	    port map(
	        a(9) => c1,
	        a(8 downto 0) => sum1,
	        b => div16,
	        b_i => '0',
	        o => output,
	        b_o => open
	    );
	
		   
end behavioral;
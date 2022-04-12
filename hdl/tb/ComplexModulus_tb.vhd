library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ComplexModulus_tb is
end ComplexModulus_tb;

architecture behavioral of ComplexModulus_tb is

	-----------------------------------------------------------------------------------
    -- Testbench constants
    -----------------------------------------------------------------------------------

	-- Clock period definitions
	constant T_CLK : time 	:= 10 ns;
	constant T_RESET : time := 5 ns;
	constant N : integer := 10;

	-----------------------------------------------------------------------------------
    -- Testbench signals
    -----------------------------------------------------------------------------------
    --Inputs
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal end_sim : std_logic := '1'; 
	signal p : std_logic_vector(N - 1 downto 0);
	signal q : std_logic_vector(N - 1 downto 0);

	--Output
	signal output : std_logic_vector(N - 1 downto 0);


 	-----------------------------------------------------------------------------------
    -- Component to test (DUT) declaration
    -----------------------------------------------------------------------------------

	component ComplexModulus is
		generic (
			Nbit : positive
		);
		port (	 
		    input1 : in std_logic_vector (Nbit - 1 downto 0);
		    input2 : in std_logic_vector (Nbit - 1 downto 0);
	        output : out std_logic_vector (Nbit - 1 downto 0)
	    );
	end component;

	begin
		-- Clock process definitions
		clk <= (not(clk) and end_sim) after T_CLK / 2;  
	  	rst <= '1' after T_RESET; 
		
		-- Instantiate the Device Under Test (DUT)
		dut: ComplexModulus 
			generic map(Nbit => N)
			port map (
				input1	=> p,
				input2	=> q,
				output  => output
			);

		d_process: process(clk, rst) 
			variable t : integer := 0; 
		  	begin
		    	if(rst = '0') then
					p <= "0000000000";
					q <= "0000000000";
					t := 0;

				elsif(rising_edge(clk)) then
			  		case(t) is   
					  	when  1  => p <= "0000000000"; q <= "0000000000";	-- p= 0   , q= 0	 
						when  2  => p <= "0000000000"; q <= "1111111111";	-- p= 0   , q=-1
						when  3  => p <= "1111111111"; q <= "0000000000";	-- p=-1   , q= 0
						when  4  => p <= "0000000000"; q <= "1000000001";	-- p= 0   , q=-511
						when  5  => p <= "0111111111"; q <= "0111111111";	-- p= 511 , q= 511	
						when  6  => p <= "0111111111"; q <= "1000000001";	-- p= 511 , q=-511	
						when 10 => end_sim <= '0';
			            when others => null; 
						
					end case;
					  
				t := t + 1; 

				end if;

			end process;

end behavioral;
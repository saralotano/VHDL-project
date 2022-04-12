library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity DivBy2_tb is
end DivBy2_tb;

architecture behavioral of DivBy2_tb is

	-----------------------------------------------------------------------------------
    -- Testbench constants
    -----------------------------------------------------------------------------------

	-- Clock period definitions
	constant T_CLK : time 	:= 10 ns;
	constant T_RESET : time := 5 ns;
	constant N : integer := 9;

	-----------------------------------------------------------------------------------
    -- Testbench signals
    -----------------------------------------------------------------------------------
    --Inputs
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal end_sim : std_logic := '1'; 
	signal input : std_logic_vector(N - 1 downto 0);

	--Output
	signal output : std_logic_vector(N - 1 downto 0);


 	-----------------------------------------------------------------------------------
    -- Component to test (DUT) declaration
    -----------------------------------------------------------------------------------

	component DivBy2 is
		generic (
			Nbit : positive
		);
		port ( 
			input 	: in  std_logic_vector (N - 1 downto 0);
			output 	: out std_logic_vector (N - 1 downto 0)
		);
	end component;

	begin

		-- Clock process definitions
		clk <= (not(clk) and end_sim) after T_CLK / 2;  
	  	rst <= '1' after T_RESET; 

		-- Instantiate the Device Under Test (DUT)
		dut: DivBy2 
			generic map(
				Nbit => N
			)
			port map (
				input		=> input,
				output		=> output
			);

	d_process: process(clk, rst) 
			variable t : integer := 0; 
		  begin
		    if(rst = '0') then
			  input  <= "000000000";
			  t := 0;

			elsif(rising_edge(clk)) then
			  case(t) is   
			  	when  1  => input  <= "000000001";	 -- input = 1	  
			 	when  2  => input  <= "000000010";	 -- input = 2	 
			 	when  3  => input  <= "000000011";	 -- input = 3	 
			 	when  4  => input  <= "000000100";	 -- input = 4  		    			 
			 	when  5  => input  <= "000000101";	 -- input = 5 	 		 
	         	when  6  => input  <= "111111111";	 -- input = 511	 
			 	when  7  => input  <= "111111110";	 -- input = 510
			 	when  8  => input  <= "111111101";	 -- input = 509
			 	when  9  => input  <= "111111100";	 -- input = 508		
				when 10 => end_sim <= '0'; 
	            when others => null; 
				
			  end case;
			  t := t + 1; 
			end if;
		  end process;

end behavioral;
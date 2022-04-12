library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity Abs_tb is
end Abs_tb;

architecture behavioral of Abs_tb is

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
	signal input : std_logic_vector(N - 1 downto 0);

	--Output
	signal output : std_logic_vector(N - 1 downto 0);


 	-----------------------------------------------------------------------------------
    -- Component to test (DUT) declaration
    -----------------------------------------------------------------------------------

	component Abs_module is
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
		dut: Abs_module 
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
			  input  <= "0000000000";
			  t := 0;

			elsif(rising_edge(clk)) then
			  case(t) is   
			  	when  1  => input  <= "0000000000";	 -- input = 0
			  	when  2  => input  <= "0000000001";	 -- input = +1
			 	when  3  => input  <= "1111111111";	 -- input = -1
			 	when  4  => input  <= "0000000010";  -- input = +2
			 	when  5  => input  <= "1111111110";  -- input = -2		    			 		 		 
			 	when  6  => input  <= "0111111110";  -- input = +510
			 	when  7  => input  <= "1000000010";	 -- input =	-510 
	         	when  8  => input  <= "0111111111";	 -- input = +511
			 	when  9  => input  <= "1000000001";	 -- input =	-511 					
				when  10 => end_sim<= '0'; 
	            when others => null; 
				
			  end case;
			  t := t + 1; 
			end if;
		  end process;

end behavioral;
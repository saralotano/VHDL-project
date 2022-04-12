library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity MaxMin_tb is
end MaxMin_tb;

architecture behavioral of MaxMin_tb is

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
	signal input1 : std_logic_vector(N - 1 downto 0);
	signal input2 : std_logic_vector(N - 1 downto 0);

	--Outputs
	signal max : std_logic_vector(N - 1 downto 0);
	signal min : std_logic_vector(N - 1 downto 0);


 	-----------------------------------------------------------------------------------
    -- Component to test (DUT) declaration
    -----------------------------------------------------------------------------------

	component MaxMin is
		generic (
			Nbit : positive
		);
		port ( 
			input1 : in std_logic_vector (Nbit - 1 downto 0);
        	input2 : in std_logic_vector (Nbit - 1 downto 0);
        	max    : out std_logic_vector(Nbit - 1 downto 0);
        	min    : out std_logic_vector(Nbit - 1 downto 0)
		);
	end component;

	begin

		-- Clock process definitions
		clk <= (not(clk) and end_sim) after T_CLK / 2;  
	  	rst <= '1' after T_RESET; 

		-- Instantiate the Device Under Test (DUT)
		dut: MaxMin 
			generic map(
				Nbit => N
			)
			port map (
				input1	=> input1,
				input2	=> input2,
				max		=> max,
				min		=> min
			);


	d_process: process(clk, rst) 
			variable t : integer := 0; 
		  begin
		    if(rst = '0') then
			  input1  <= "000000000";
			  input2  <= "000000000";
			  t := 0;

			elsif(rising_edge(clk)) then
			  case(t) is   
			  	when  1  => input1 <= "000000000"; input2 <= "000000001";	--input1 = 0, input2 = 1 
				when  2  => input1 <= "000000001"; input2 <= "000000010";	--input1 = 1, input2 = 2
				when  3  => input1 <= "111111111"; input2 <= "111111110";	--input1 = 511, input2 = 510
				when  4  => input1 <= "000000000"; input2 <= "111111111";	--input1 = 0, input2 = 511 
				when  5  => input1 <= "000000001"; input2 <= "111111111";	--input1 = 1, input2 = 511 		
				when  10 => end_sim<= '0'; 
	            when others => null; 
				
			  end case;
			  t := t + 1; 
			end if;
		  end process;

end behavioral;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity FullAdder_tb is
end FullAdder_tb;
   
architecture behavioral of FullAdder_tb is
   
	-----------------------------------------------------------------------------------
    -- Testbench constants
    -----------------------------------------------------------------------------------

    -- Clock period definitions
	constant T_CLK  : time := 10 ns;
	constant T_RESET  : time := 5 ns;
	constant N_bit  : natural := 9;
		
    -----------------------------------------------------------------------------------
    -- Testbench signals
    -----------------------------------------------------------------------------------
    --Inputs
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal end_sim : std_logic := '1';
	signal a_tb, b_tb : std_logic_vector(N_bit - 1 downto 0);

	--Outputs
	signal o_tb : std_logic_vector(N_bit - 1 downto 0);
	signal c_o_tb : std_logic;


 	-----------------------------------------------------------------------------------
    -- Component to test (DUT) declaration
    -----------------------------------------------------------------------------------	
   
    component FullAdder_Nbit is 
        generic (Nbit : integer := 9);
	    port(
            a    : in std_logic_vector(Nbit - 1 downto 0);
            b    : in  std_logic_vector(Nbit - 1 downto 0);
            c_i  : in std_logic;
            o    : out  std_logic_vector(Nbit - 1 downto 0);
            c_o  : out std_logic
        );
	end component;
   

   begin
   
        clk <= (not(clk) and end_sim) after T_CLK / 2;  
	  	rst <= '1' after T_RESET; 

		-- Instantiate the Device Under Test (DUT)		
		dut: FullAdder_Nbit     
		    generic map(Nbit => N_bit)
	   
            port map(
                a    => a_tb,
                b    => b_tb,
                c_i  => '0',
                o    => o_tb,
                c_o => c_o_tb
            );


        d_process: process(clk, rst) 
			variable t : integer := 0; 
		 	begin
			    if(rst = '0') then
					a_tb <= "000000000";
					b_tb <= "000000000";
					t := 0;

				elsif(rising_edge(clk)) then
				 	case(t) is  
				  		when  1  => a_tb <= "000000000"; b_tb <= "000000001";	--input1 = 0, input2 = 1	 
						when  2  => a_tb <= "000000000"; b_tb <= "111111111";	--input1 = 0, input2 = 511
						when  3  => a_tb <= "000000001"; b_tb <= "111111111";	--input1 = 1, input2 = 511
						when  4  => a_tb <= "111111110"; b_tb <= "111111111";	--input1 = 510, input2 = 511 
						when  5  => a_tb <= "111111111"; b_tb <= "111111111";	--input1 = 511, input2 = 511 
						when 10 => end_sim <= '0'; 
			            when others => null; 
					
				  	end case;

				t := t + 1; 

				end if;

		  end process;	
        
   end behavioral;